class TripsController < ApplicationController

	def create2
		if params[:source] == "countries"
			@countries = Country.find(params[:country_ids])
			@new_state = params[:commit] == "Mark selected as visited"? "Visited" : "Not Visited"
		else
			currencies = Currency.includes(:country).find(params[:currency_ids])
			@countries = currencies.map{|currency| currency.country}.uniq
			@new_state = params[:commit] == "Mark selected as collected"? "Collected" : "Not Collected"
		end

		Trip.transaction do
			@countries.each do
				|country|
				if params[:commit] == "Mark selected as visited" or params[:commit] == "Mark selected as collected"
					current_user.visit country
				else
					current_user.unvisit country
				end
			end
		end

		@currencies = Currency.includes(:country)
		@visited_countries = Trip.includes(:country).where(:user_id => current_user.id).map{|trip| trip.country}

		respond_to do |format|
      format.html do
        redirect_to :back
      end
      format.js
    end

	end

	def create
		if params[:source] == "countries"
			countries = params[:country_ids].nil? ? [] :Country.find(params[:country_ids])
		else
			currencies = params[:currency_ids].nil? ? [] : Currency.includes(:country).find(params[:currency_ids])
			countries = currencies.map{|currency| currency.country}.uniq
		end

	  Trip.transaction do
			#uncheck
			current_user.countries.each do
				|visited_country|
				if !countries.include?(visited_country) 
					current_user.unvisit visited_country
				end	
			end
		
			#check
			countries.each do
				|country|
				trip = Trip.find_or_create_by_country_id(country.id, :user => current_user)	
			end		

			@source = params[:source]
			@currencies = Currency.includes(:country)
			@countries = Country.joins(:currencies)

			@visited_countries = Trip.includes(:country).where(:user_id => current_user.id).map{|trip| trip.country} 
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
