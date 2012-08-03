Feature: check all

	New story: Logged-in user can check and uncheck all checkboxes
	
	@javascript
	Scenario: simultaneously check and unckeck all check-boxes on Countries page 
    Given the following countries exist and have related currencies:
      |name|code|
      |CountryOne|c1|
      |CountryTwo|c2|
      |CountryThree|c3|
      |CountryFour|c4|
      |CountryFive|c5|
    And I have logged-in as "cucumber_user@host.com" to CurrencyTracker
    And I'm opening index country page
    When I check checkbox in head of countries table 
		Then All checkboxes related to the following countries have to be checked:
			|code|
      |c1|
      |c2|
      |c3|
      |c4|
     	|c5|
    When I uncheck checkbox in head of countries table 
    Then All checkboxes related to the following countries have to be unchecked:
      |code|
      |c1|
      |c2|
      |c3|
      |c4|
      |c5|


  @javascript
  Scenario: simultaneously check and unckeck all check-boxex on Countries page 
    Given the following currencies exist:
      |name|code|
      |CurrencyOne|c1|
      |CurrencyTwo|c2|
      |CurrencyThree|c3|
      |CurrencyFour|c4|
    And I have logged-in as "cucumber_user@host.com" to CurrencyTracker
    When I'm opening index currencies page
    When I check checkbox in head of countries table 
    Then All checkboxes related to the following currencies have to be checked:
      |code|
      |c1|
      |c2|
      |c3|
      |c4|
    When I uncheck checkbox in head of countries table 
    Then All checkboxes related to the following currencies have to be unchecked:
      |code|
      |c1|
      |c2|
      |c3|
      |c4|