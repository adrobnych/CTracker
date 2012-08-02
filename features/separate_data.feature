Feature: Separate data

	New Story: User has to have ability to see only his data in the system

	Scenario: Country visited by one user should not be marked as visited for another user.

		Given Two users "John@host.com" and "Bill@host.com" have the same country "Uganda" in their listing. 
		And "They had no visit to this country before
		When "John" marked "Uganda" as visited 
		Then Bill still see "Uganda" as not visited country

