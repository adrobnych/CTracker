When /^I'm opening index currencies page$/ do #'
  visit "/"
end


Given /^the following countries and currencies exist:$/ do |table|
  # table is a Cucumber::Ast::Table
   table.hashes.each do
		|row|
		country = Country.create!({:code => row["country_code"], :name => row["country_name"]})
		currency = Currency.create!({:code => row["currency_code"], :name => row["currency_name"]})
		currency.country = country
		currency.save!
	end
end

Given /^CountryOne has additional currency "(.*?)" with code "(.*?)"$/ do |currency_name, currency_code|
  country = Country.find("c1")
  currency = Currency.create!(:code => currency_code, :name => currency_name)
  currency.country = country
  currency.save!
end

Then /^I should see currencies with code "(.*?)", "(.*?)", "(.*?)" and "(.*?)" as visited$/ do |arg1, arg2, arg3, arg4|
  [arg1, arg2, arg3, arg4].each do
		|code|
  		currency = Currency.find(code)
  		visit currency_path(currency)
			page.should have_content "Status: Collected"
	end
end

Then /^I should see currencies with code "(.*?)" and "(.*?)" as not collected$/ do |arg1, arg2|
  [arg1, arg2].each do
    |code|
    @currency = Currency.find(code)
    visit currency_path(@currency)
    page.should have_content "Status: Not Collected"
  end
end

When /^I uncheck "(.*?)", "(.*?)" and "(.*?)" checkboxes$/ do |arg1, arg2, arg3|
  [arg1, arg2, arg3].each do
    |code|
    uncheck("checkbox_code_#{code}")
  end
end
