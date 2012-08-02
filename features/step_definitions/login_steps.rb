Given /^I was not logged\-in to CurrencyTracker$/ do
  visit('/users/sign_out')
end

When /^I'm on landing page$/ do
  visit '/'
	page.should have_content "Currencies" 
end

Then /^I should not see text Hello$/ do
	page.should_not have_content "Hello"
end

Given /^This is my first login into CurrencyTracker$/ do
  User.all.should be_empty
end

#class Credentials
#	attr_accessor :screen_name
#end

Given /^I have logged-in as "(.*?)" to CurrencyTracker$/ do 
	|user_email|
  password = "cucumber_password"
  User.new(:email => user_email, :password => password, :admin => true).save!

  visit '/users/sign_in'
  fill_in "user_email", :with=>user_email
  fill_in "user_password", :with=>password
  click_button "Sign in"
end

When /^I fill valid email, password and confirmation_password$/ do
  email = "cucumber_email@host.com"
  password = "cucumber_password"
  confirmation_password = "cucumber_password"
  
  visit '/users/sign_up'
  fill_in "user_email", :with=>email
  fill_in "user_password", :with=>password
  fill_in "user_password_confirmation", :with=>confirmation_password
  click_button "Sign up"
end

Then /^I have to see "(.*?)", and my email: "(.*?)"$/ do |greeting_text, email|
  page.should have_content greeting_text
  page.should have_content email
end


When /^I click on logout link$/ do
  click_link("logout")
end


