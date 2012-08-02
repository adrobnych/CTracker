CurrencyTracker
===============

CurrencyTracker allows you to track your personal collection of world currencies, by tagging the countries that you've visited along your travels.

Features
--------

Mass visit/unvisit, collection/uncollection.

Filtering.

Line and Pie chart.

Admin role.

Multiuser.


Startup procedures
------------------

In case of errors related to gems:

	bundle update 

Feed data before first launch of the app:

	bundle exec rake db:seed

Demo user credentials:

	email: demo@host.name
	password: demo123

Running tests
------------------

	cucumber

	bundle exec rake spec 

	bundle exec rake test

To Do
-----

More Rspec tests

Notification popup window before collection of not full set of currencies (if some country has more then one currency).

More admin functions for adding currencies and countries.

Pagination of Line Chart.




