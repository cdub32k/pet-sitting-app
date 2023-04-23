# README

* Ruby version<br>
3.2.2

* Rails version<br>
7.0.4.3

* Operating System<br>
Developed on Ubuntu 22.04 but should run on any OS.

* System dependencies<br>
Ruby, Rails, PostgreSQL

* Configuration and Setup<br>
Run the following commands from the project directory:

  ```
  bundle install
  rake db:create
  rake db:migrate
  rake db:seed
  rails server
  ```

  App will be running on http://localhost:3000

* How to run the test suite<br>
  Run the following commands:

  ```
  RAILS_ENV=test rake db:migrate # first time only
  rails test # price engine and booking model unit tests
  bundle exec rspec # integration tests
  ```