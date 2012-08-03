Feature: Filtering

	New Story: Logged-in user can filter countries and currencies by name
	
	@javascript
	Scenario: filter countries 
    Given the following countries exist and have related currencies:
      |name|code|
      |CountryOne|c1|
      |CountryTwo|c2|
      |CountryThree|c3|
      |CountryFour|c4|
      |CountryFive|c5|
    And I have logged-in as "cucumber_user@host.com" to CurrencyTracker
    When I am on the countries page 
		And I've entered text "countryt"
    Then I should not see country "CountryOne" in first row
		And I should see country "CountryTwo" in first row

	@javascript
	Scenario: filter currencies 
    Given the following currencies exist:
      |name|code|
      |CurrencyOne|cu1|
      |CurrencyTwo|cu2|
      |CurrencyThree|cu3|
      |CurrencyFour|cu4|
      |CurrencyFive|cu5|
    And I have logged-in as "cucumber_user@host.com" to CurrencyTracker
     When I am on the currencies page
		And I've entered text "currencyt"
    Then I should not see currency "CurrencyOne" in first row
		And I should see currency "CurrencyTwo" in first row

