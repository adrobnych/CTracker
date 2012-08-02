Given /^The coutry "(.*?)" has currency "(.*?)"$/ do |country, currency|
  @country = Country.create! :name => country, :code => "country_code"
	@currency = Currency.create! :name => currency, :code => "currency_code", :country_id => @country.id
end

Given /^I visited the page this currency$/ do
  visit currency_path(@currency)
end

Then /^I should see "(.*?)" text with hyperlink to its counry page$/ do |country_name_text|
  page.should have_content country_name_text
	click_link country_name_text
  page.should have_content "Code: "
  page.should have_content "country_code"
	page.should have_link "Back"
end

