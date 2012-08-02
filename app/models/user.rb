class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin

	has_many :trips

	def visited? country
    Trip.where(:user_id => self.id, :country_id => country.code).size > 0
	end

	def visit country
		trip = Trip.create! :user => self, :country => country if ! visited?(country)
	end

	def unvisit country
		trip = Trip.where(:user_id => self.id, :country_id => country.code).first
    
		if trip != nil
       trip.destroy
		end
   
	end

	def visited_countries
    trips.includes(:country).map { |trip| trip.country }
  end

  def not_visited_countries
    Country.joins(:currencies) - visited_countries
  end

  def collected_currencies
    trips.includes(:country => :currencies).map { |trip| trip.country.currencies }.flatten
  end

  def not_collected_currencies
    Currency.all - collected_currencies
  end

  def last_6_months_visits
		current_month = Time.now.month
    last_6_months = []
		6.times do
			|shift|
			last_6_months = last_6_months + [DateTime.now - shift.month] 
		end
		
		visits = []
		current_number = 0
		last_6_months.reverse.each do
			|month|
			new_number =  Trip.trips_in_month(self.id, month.beginning_of_month, month.end_of_month).count
			current_number += new_number
      visits = visits + 
				[{ :month => month.strftime("%B"), :number => current_number}]
		end
		visits.reverse
	end

	def last_6_months_collections
		current_month = Time.now.month
    last_6_months = []
		6.times do
			|shift|
			last_6_months = last_6_months + [DateTime.now - shift.month] 
		end
		collections = []
		current_number = 0
		last_6_months.reverse.each do
			|month|
			trips = Trip.trips_in_month(self.id, month.beginning_of_month, month.end_of_month)
			collections_number = 0
			trips.each do
				|trip|	
				collections_number += trip.country.currencies.size	
			end
			current_number += collections_number
      collections = collections + 
				[{ :month => month.strftime("%B"), :number => current_number}]
		end
		collections.reverse
	end
end
