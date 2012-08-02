Feature: visit country
  
  Updated Story: Logged-in user can mark any not visited country from his list as visited
	

	Scenario: check if country was visited
    Given There is coutry "Ukraine" in my list
    And I have logged-in as "me@host.com" to CurrencyTracker
    And I've visited it before
    When I'm opening its country page
    Then I should see "Status: Visited"

	

