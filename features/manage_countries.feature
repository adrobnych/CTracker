Feature: Manage countries
  In order to manage his travel itinerary
  Mr. Smart
  wants to manage the countries he has visited.

  Scenario: List Countries
    Given the following countries exist and have related currencies:
      |name|code|
      |CountryOne|c1|
      |CountryTwo|c2|
      |CountryThree|c3|
      |CountryFour|c4|
      |CountryFive|c5|
		And I have logged-in as "cucumber_user@host.com" to CurrencyTracker
    And I am on the countries page
    Then I should see the following table:
      |Name|Code|
      |CountryOne|c1|
      |CountryTwo|c2|
      |CountryThree|c3|
      |CountryFour|c4|
      |CountryFive|c5|


  Scenario: Admin access for editing
    Given I have logged-in as "cucumber_user@host.com" to CurrencyTracker
		And I am on a country page
    And "cucumber_user@host.com" have no admin rights
    When I follow "Edit"
    Then I should back to the country page
