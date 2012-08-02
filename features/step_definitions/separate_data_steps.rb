Given /^Two users "(.*?)" and "(.*?)" have the same country "(.*?)" in their listing\.$/ do |user1_email, user2_email, some_country|
	@user1 = User.new(:email => user1_email, :password => "password")
	@user1.save
	@user2 = User.new(:email => user2_email, :password => "password")
  @user2.save
  @some_country = Country.create! :name => "Uganda", :code => "ug"
end

Given /^"They had no visit to this country before$/ do 
  @user1.visited?(@some_country).should be_false
  @user2.visited?(@some_country).should be_false
end

When /^"(.*?)" marked "(.*?)" as visited$/ do |user1_name1, some_country|
  @user1.visit @some_country
	@user1.visited?(@some_country).should be_true
end

Then /^Bill still see "(.*?)" as not visited country$/ do |some_country|
  @user2.visited?(@some_country).should be_false
end

