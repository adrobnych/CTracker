When /^I'm opening index country page$/ do
  visit '/countries'
end

Then /^I should see checkboxes there related to ids:$/ do |table|
  table.hashes.each do
		|id|
		page.should have_css ".check[id='checkbox_code_#{id["code"]}']"	
	end
end

When /^I check "(.*?)", "(.*?)" and "(.*?)" checkboxes$/ do |arg1, arg2, arg3|
	[arg1, arg2, arg3].each do
		|code|
		check("checkbox_code_#{code}")
	end
end

Then /^I should see contries with code "(.*?)", "(.*?)" and "(.*?)" as visited$/ do |arg1, arg2, arg3|
	[arg1, arg2, arg3].each do
		|code|
  		@country = Country.find(code)
  		visit country_path(@country)
			page.should have_content "Status: Visited"
	end
end

When /^I press button "(.*?)"$/ do |button|
  click_button button
end

Given /^I've visited those countries before$/ do #'
  Country.all.each do
  	|country|
  	User.where(:email => "cucumber_user@host.com").first.visit country
  end
end

Then /^I should see contries with code "(.*?)", "(.*?)" and "(.*?)" as not visited$/ do |arg1, arg2, arg3|
  [arg1, arg2, arg3].each do
		|code|
  	@country = Country.find(code)
  	visit country_path(@country)
		page.should have_content "Status: Not Visited"
	end
end