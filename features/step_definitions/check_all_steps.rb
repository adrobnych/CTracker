When /^I check checkbox in head of countries table$/ do
  find(:css, "#checkbox_master").set(true)
end

Then /^All checkboxes related to the following countries have to be checked:$/ do |table|
  table.hashes.each do
		|row|
		find(:css, ".check[id='checkbox_code_#{row["code"]}']").selected?.should be_true	
	end
end

When /^I uncheck checkbox in head of countries table$/ do
  find(:css, "#checkbox_master").set(false)
end

Then /^All checkboxes related to the following countries have to be unchecked:$/ do |table|
  table.hashes.each do
		|row|
		find(:css, ".check[id='checkbox_code_#{row["code"]}']").selected?.should be_false	
	end
end

Then /^All checkboxes related to the following currencies have to be checked:$/ do |table|
  table.hashes.each do
		|row|
		find(:css, ".check[id='checkbox_code_#{row["code"]}']").selected?.should be_true
	end
end

Then /^All checkboxes related to the following currencies have to be unchecked:$/ do |table|
  table.hashes.each do
		|row|
		find(:css, ".check[id='checkbox_code_#{row["code"]}']").selected?.should be_false	
	end
end