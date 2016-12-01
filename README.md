ShopSpree Sales
===============
`Rails: 4.2.4` `Spree: 3.0.x (branch: 3-0-stable)`

Extends [hhff/spree\_ams](https://github.com/hhff/spree_ams) gem.

ShopSpree Sales app is a sample Spree app providing user facing API endpoints.

The app also uses following frequently used Spree extensions.

* [spree/spree\_auth\_devise](https://github.com/spree/spree_auth_devise)
* [spree/spree\_gateway](https://github.com/spree/spree_gateway)
* [spree-contrib/spree\_mail\_settings](https://github.com/spree-contrib/spree_mail_settings)
* [spree-contrib/spree\_reviews](https://github.com/spree-contrib/spree_reviews)
* [spree-contrib/spree\_address\_book](https://github.com/spree-contrib/spree_address_book)
* [spree-contrib/spree\_wishlist](https://github.com/spree-contrib/spree_wishlist)
* [spree-contrib/spree\_email\_to\_friend](https://github.com/spree-contrib/spree_email_to_friend)

[VinSol](http://vinsol.com) has also created [Spree iOS](https://github.com/vinsol-spree-contrib/shopSpree-iOS) and [Spree Android](https://github.com/vinsol-spree-contrib/spree-android) sample applications using this extension.

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
