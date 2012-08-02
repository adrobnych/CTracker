When /^I've entered text "(.*?)"$/ do |some_text|
	#fill_in 'filter', :with => 'some text'
	find("#filter").native.send_keys some_text
end


Then /^I should not see country "(.*?)" in first row$/ do |country|
	find('table tr.named_row').should_not have_content country
end

Then /^I should see country "(.*?)" in first row$/ do |country|
	find('table tr.named_row').should have_content country
end

Given /the following currencies exist:/ do |currencies|
  Currency.create!(currencies.hashes)
end

Then /^I should not see currency "(.*?)" in first row$/ do |currency|
  find('table tr.named_row').should_not have_content currency
end

Then /^I should see currency "(.*?)" in first row$/ do |currency|
  find('table tr.named_row').should have_content currency
end

