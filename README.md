ShopSpree Sales
===============

ShopSpree Sales is a Spree app built for use with Shop Spree API.

## Installation

* Clone this repository.

* Copy the following files from '/config' directory:
  * database.yml.example => database.yml

* Install all the necessary dependencies using the bundler.

  ```
  bundle install
  ```

* Create a database for the application using:

  ```
  bundle exec rake db:create
  ```

* Run the migrations to create all the tables and indices:

  ```
  bundle exec rake db:migrate
  ```

* Optionally, you can seed data from Spree and get sample data with the following commands:

  ```
  bundle exec rake db:seed
  bundle exec rake spree_sample:load
  ```

* Now start your rails application using:

  ```
  rails server
  ```


Credits
-------

[![vinsol.com: Ruby on Rails, iOS and Android developers](http://vinsol.com/themes/vinsoldotcom-theme/images/new_img/vin_logo.png "Ruby on Rails, iOS and Android developers")](http://vinsol.com)

Copyright (c) 2016 [vinsol.com](http://vinsol.com "Ruby on Rails, iOS and Android developers"), released under the New MIT License
