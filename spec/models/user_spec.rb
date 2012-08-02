require 'spec_helper'

describe User do

	it "is not valid without a email and password" do
		user = User.new		
		user.should_not be_valid
	end

	context "visiting countries" do

		before(:each) do
			@user = User.new :email => "some_fresh_user@host.com", :password => "secret"	
			@country = Country.create! :name => "some_country", :code => "sc"
		end	

		describe "#visited?" do
			it "should return true if user not visited country before" do
				@user.visited?(mock_model("Country", :name => "some_country")).should be_false
			end

			it "should return false if user visited country before" do
				trip = Trip.create! :user => @user, :country => @country
				@user.visited?(@country).should be_true
			end
		end

		describe "#visit" do
			it "should change result of visited? method call to true" do
				@user.visited?(@country).should be_false
				@user.visit @country
				@user.visited?(@country).should be_true
			end
		end

		describe "#unvisit" do
			it "should change result of visited? method call to false" do
				@user.visit @country
				@user.visited?(@country).should be_true
				@user.unvisit @country
				@user.visited?(@country).should be_false
			end
		end

		describe "#last_6_months_visits" do
			it "should return visits numbers distributed over last 6 month" do
				other_country = Country.create! :name => "some_other_country", :code => "so"
				@user.visit @country
				@user.visit other_country
				current_month = Time.now.month
				last_6_months_names = []
				6.times do
					|shift|
					last_6_months_names = last_6_months_names + [(DateTime.now - shift.month).strftime("%B")] 
				end
				@user.last_6_months_visits.should == [{:month=>last_6_months_names[0], :number => 2}, {:month => 	last_6_months_names[1], :number => 0}, {:month => last_6_months_names[2], :number => 0}, {:month => last_6_months_names[3], :number => 0}, {:month => last_6_months_names[4], :number => 0}, { :month => last_6_months_names[5], :number => 0}]
			end
		end

		describe "#last_6_months_collections" do
			it "should return collections numbers distributed over last 6 month" do
				other_country = Country.create! :name => "some_other_country", :code => "so"
				currency_one = Currency.create! :name => "ones", :code => "ons", :country_id => @country.code
				currency_two = Currency.create! :name => "twoes", :code => "tws", :country_id => other_country.code
				currency_three = Currency.create! :name => "threes", :code => "trs", :country_id => other_country.code

				@user.visit @country
				@user.visit other_country
				current_month = Time.now.month
				last_6_months_names = []
				6.times do
					|shift|
					last_6_months_names = last_6_months_names + [(DateTime.now - shift.month).strftime("%B")] 
				end
				@user.last_6_months_collections.should == [{:month=>last_6_months_names[0], :number => 3}, {:month => last_6_months_names[1], :number => 0}, {:month => last_6_months_names[2], :number => 0}, {:month => last_6_months_names[3], :number => 0}, {:month => last_6_months_names[4], :number => 0}, { :month => last_6_months_names[5], :number => 0}]
			end
		end
	end

end
