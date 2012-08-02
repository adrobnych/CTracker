Given /^There is coutry "(.*?)" in my list$/ do |country|
  @country = Country.create! :name => country, :code => "country_code1"
end

Given /^I've visited it before$/ do  #'
  @me = User.where(:email => "me@host.com").first
  @me.should_not == nil
	@me.visit @country
end

When /^I'm opening its country page$/ do #'
  visit country_path(@country)
	page.should have_content "Code: "
  page.should have_content "country_code1"
	page.should have_link "Back"
end


