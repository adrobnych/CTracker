class TripsController < ApplicationController

	def create
		if params[:source] == "countries"
			@countries = Country.find(params[:country_ids])
			@new_state = params[:commit] == "Mass Visit"? "Visited" : "Not Visited"
		else
			currencies = Currency.includes(:country).find(params[:currency_ids])
			@countries = currencies.map{|currency| currency.country}.uniq
			@new_state = params[:commit] == "Mass Collection"? "Collected" : "Not Collected"
		end

		Trip.transaction do
			@countries.each do
				|country|
				if params[:commit] == "Mass Visit" or params[:commit] == "Mass Collection"
					current_user.visit country
				else
					current_user.unvisit country
				end
			end
		end

		respond_to do |format|
      format.html do
        redirect_to :back
      end
      format.js
    end

	end

	def chart_data

		data_collection = params[:source] == "countries" ?
			current_user.last_6_months_visits : current_user.last_6_months_collections

		body = data_collection.map do 
			|hash| 
			{"c" => [{"v" => hash[:month], "f" => nil},
							 {"v" => hash[:number], "f" => nil}]}
		end

		if params[:source] == "countries"
    	response = totals_response("Monthes", "Visits", body.reverse)
    else
    	response = totals_response("Monthes", "Collections", body.reverse)
    end

    respond_to do |format|
      format.json  { render :json => response }
    end
  end

	

  def totals_data

		if params[:source] == "countries"

			body = totals_response_body("Visited", 
	  							current_user.visited_countries.count,
	  							"Not visited",
	  							current_user.not_visited_countries.count)

			response = totals_response("Visited?", "Number of countries", body)
		else
			body = totals_response_body("Collected", 
	  							current_user.collected_currencies.count,
	  							"Not collected",
	  							current_user.not_collected_currencies.count)

			response = totals_response("Collected?", "Number of currencies", body)
		end

		respond_to do |format|
      format.json  { render :json => response }
    end
  end

  private

  def totals_response_body(positive_flag, positive_count, negative_flag, negative_count) 
  	[ 
			{"c" => [{"v" => positive_flag, "f" => nil},
							 {"v" => positive_count, "f" => nil}]},
			{"c" => [{"v" => negative_flag, "f" => nil},
							 {"v" => negative_count, "f" => nil}]}
		]
	end

	def totals_response(status_label, number_label, body)
			{
				"cols" => 
					[{"id"=>"","label"=>status_label, "pattern"=>"", "type"=>"string"},
					{"id"=>"","label"=>number_label, "pattern"=>"", "type"=>"number"}],
				"rows" => body
			}
	end

end
