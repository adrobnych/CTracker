# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# loading countries and currencies at first time

puts "cleaning DB..."
Currency.delete_all
Country.delete_all
Trip.delete_all
User.delete_all

puts "loading countries and currencies..."
ActiveRecord::Base.transaction do
	DataUpdater.instance.update

	puts "creating demo user..."
	demo_user = User.create! :email => "demo@host.name", :password => "demo123", :admin => true

	puts "simulating history of his visits..." 
	Country.joins(:currencies)[0..30].each do
		|country| 
		Trip.create 	:user => demo_user, :country => country, 
								:created_at => Time.now - rand(180).days
	end
end
