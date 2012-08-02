Given /^the following countries exist and have related currencies:$/ do |countries|  
  Country.create!(countries.hashes).each do
    |country|
    currency = Currency.create!(:name => "#{country.name}_currency", :code => "#{country.code}cu")
    currency.country = country
    currency.save!
  end
end

Then /^I should see the following table:$/ do |expected_table|
  document = Nokogiri::HTML(page.body)
  #rows = document.css('section>table>tr').collect { |row| row.xpath('.//th|td').collect {|cell| cell.text } }
	rows = document.css('section>form>table>tr').collect { |row| row.xpath('.//th|td').collect {|cell| cell.text.strip } }
  expected_table.diff!(rows)
end

Then /^\{javascript\} I should see the following table:$/ do |expected_table|
  document = Nokogiri::HTML(page.body)
  rows = document.css('section table tr').collect { |row| row.xpath('.//th|td').collect {|cell| cell.text } }
  rows = rows[1..rows.size]
  expected_table.diff!(rows)
end

Given /^"(.*?)" have no admin rights$/ do |user_email|
  user = User.where(:email => user_email).first
  user.admin = false
  user.save
end

Then /^I should back to the country page$/ do
  page.should have_content "Code: tc"
end