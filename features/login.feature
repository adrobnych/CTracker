Feature: Login

	User must have ability to log-in into the system using his login and password. 

	Scenario: Not logged-in user

		Not logged-in users should see a button for Twitter login on landing page.

		Given I was not logged-in to CurrencyTracker
		When I'm on landing page 
		Then I should not see text Hello

	@javascript
	Scenario: Successful login

		User was not logged-in and it's his first time login into CurrencyTracker. After registration he can see "Hello user_name", his twitter avatar on landing page of CurrencyTracker.

		Given This is my first login into CurrencyTracker
		And I'm on landing page 
		When I fill valid email, password and confirmation_password
		Then I have to see "Hello", and my email: "cucumber_email@host.com" 

	
	Scenario: Logout

		After logout user shall not see greeting text  

		Given I have logged-in as "cucumber_user@host.com" to CurrencyTracker
		And I'm on landing page 
		When I click on logout link
		Then I should not see text Hello



