class CountriesController < ApplicationController
   before_filter :is_admin?, :only => [:edit, :update, :create]

  # GET /countries
  # GET /countries.xml
  def index
    @countries = Country.joins(:currencies)  #all
    @visited_countries = Trip.includes(:country).where(:user_id => current_user.id).map{|trip| trip.country}


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.xml
  def show
    @country = Country.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @country }
    end
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
  end

  # POST /countries
  # POST /countries.xml
  def create
    @country = Country.new(params[:country])

    respond_to do |format|
      if @country.save
        format.html { redirect_to(@country, :notice => 'Country was successfully created.') }
        format.xml  { render :xml => @country, :status => :created, :location => @country }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /countries/1
  # PUT /countries/1.xml
  def update
    @country = Country.find(params[:id])
 
		visited_flag = params["country"]["visited"]
  
		params[:country].delete :visited
    respond_to do |format|
      if @country.update_attributes(params[:country])
				if visited_flag != nil and visited_flag == "1" 
					current_user.visit(@country) 
				else 
					current_user.unvisit(@country)
				end
        format.html { redirect_to(@country, :notice => 'Country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

 

end
