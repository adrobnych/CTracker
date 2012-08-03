 Feature: mark several currencies

	New story: Logged-in user can mark several currencies and then process them as collected

	Scenario: check if there are checkboxes 
    Given the following currencies exist:
      |name|code|
      |CurrencyOne|c1|
      |CurrencyTwo|c2|
      |CurrencyThree|c3|
      |CurrencyFour|c4|
    And I have logged-in as "cucumber_user@host.com" to CurrencyTracker
    When I'm opening index currencies page
    Then I should see checkboxes there related to ids:
			|code|
      |c1|
      |c2|
      |c3|
      |c4|

	@javascript
	Scenario: Mark selected as collected
    Given the following countries and currencies exist:
      |country_name|country_code|currency_name|currency_code|
      |CountryOne|c1|Currency1|cu1|
      |CountryTwo|c2|Currency2|cu2|
      |CountryThree|c3|Currency3|cu3|
      |CountryFour|c4|Currency4|cu4|
      |CountryFive|c5|Currency5|cu5|
    And CountryOne has additional currency "Currency11" with code "cu11"
    And I have logged-in as "cucumber_user@host.com" to CurrencyTracker
    When I'm opening index currencies page
    And I check "cu1", "cu2" and "cu3" checkboxes
		And I press button "Mark selected as collected"
		Then I should see currencies with code "cu1", "cu11", "cu2" and "cu3" as visited 
		


  @javascript
  Scenario: Mark selected as not collected
    Given the following countries and currencies exist:
      |country_name|country_code|currency_name|currency_code|
      |CountryOne|c1|Currency1|cu1|
      |CountryTwo|c2|Currency2|cu2|
      |CountryThree|c3|Currency3|cu3|
      |CountryFour|c4|Currency4|cu4|
      |CountryFive|c5|Currency5|cu5|
    And CountryOne has additional currency "Currency11" with code "cu11"
    And I have logged-in as "cucumber_user@host.com" to CurrencyTracker
    And I've visited those countries before
    When I'm opening index currencies page
    And I check "cu1", "cu2" and "cu3" checkboxes
    And I press button "Mark selected as not collected"
    Then I should see contries with code "cu1", "cu2" and "cu3" as not collected 