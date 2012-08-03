Feature: mark several countries

	New story: Logged-in user can mark several countries and then process them as visited
	
	Scenario: check if there are checkboxes 
    Given the following countries exist and have related currencies:
      |name|code|
      |CountryOne|c1|
      |CountryTwo|c2|
      |CountryThree|c3|
      |CountryFour|c4|
      |CountryFive|c5|
    And I have logged-in as "cucumber_user@host.com" to CurrencyTracker
    When I'm opening index country page
    Then I should see checkboxes there related to ids:
			|code|
      |c1|
      |c2|
      |c3|
      |c4|
     	|c5|

	@javascript
	Scenario: Mark selected as visited
    Given the following countries exist and have related currencies:
      |name|code|
      |CountryOne|c1|
      |CountryTwo|c2|
      |CountryThree|c3|
      |CountryFour|c4|
      |CountryFive|c5|
    And I have logged-in as "cucumber_user@host.com" to CurrencyTracker
    When I'm opening index country page
    And I check "c1", "c2" and "c3" checkboxes
		And I press button "Save"
		Then I should see contries with code "c1", "c2" and "c3" as visited 
		

  @javascript
  Scenario: Mark selected as not visited
    Given the following countries exist and have related currencies:
      |name|code|
      |CountryOne|c1|
      |CountryTwo|c2|
      |CountryThree|c3|
      |CountryFour|c4|
      |CountryFive|c5|
    And I have logged-in as "cucumber_user@host.com" to CurrencyTracker
    And I've visited those countries before
    When I'm opening index country page
    And I uncheck "c1", "c2" and "c3" checkboxes
    And I press button "Save"
    Then I should see contries with code "c1", "c2" and "c3" as not visited 