Feature: find country by currency

  Updated Story: Logged-in user can find country by its currency

  @javascript
  Scenario: find country by currency
    Given The coutry "Ukraine" has currency "Hryvna"
    And I have logged-in as "cucumber_user@host.com" to CurrencyTracker
    And I visited the page this currency
    Then I should see "Ukraine" text with hyperlink to its counry page
 
