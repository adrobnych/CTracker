# == Schema Information
#
# Table name: trips
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  country_id :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Trip do
	before(:each) do
		@trip = Trip.new :user => mock_model("User"), :country => mock_model("Country")
	end

	it "is valid with valid attributes" do
		@trip.should be_valid
	end

	it "is not valid without a user" do
		@trip.user = nil
		@trip.should_not be_valid
	end

	it "is not valid without a country" do
		@trip.country = nil
		@trip.should_not be_valid
	end

end
