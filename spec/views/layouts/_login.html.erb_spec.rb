require 'spec_helper'

describe "layouts/_login.html.erb" do
	include Devise::TestHelpers

	context "if user was not logged-in" do

		it "dont display greeting if user was not logged-in" do
			render
			rendered.should_not contain "Hello"   
		end

	end
	
	context "if user was logged-in" do

		before(:each) do
			@user = User.new(:email => "some_user@host.com", :password => "secret")
			@user.save
			sign_in @user
		end

		it "displays 'Hello'" do
			render
			rendered.should contain "Hello" 
		end

		it "displays email" do
			render
			rendered.should contain "some_user@host.com" 
		end

		it "displays logout link" do
			render
			rendered.should have_selector("a",
				:href => "/users/sign_out")
		end

	end
end
