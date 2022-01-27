# README

* Ruby version 3.0.1

* System dependencies

* Configuration

* Database creation
  - `rake db:create` to create the database
  - `rake db:migrate` to create the tables

* Database initialization

* How to run the test suite
  - Simply run `rspec spec` to run all the available tests
  - External api documentation: https://technical-challenge.redoc.ly/

* Services (job queues, cache servers, search engines, etc.)
  - CreateUser service for creating the requested user
  - CreateRepositories service for creating the repositories for the requested user
  - Searchkick on repository fields: name, full_name and description using the parameter `query`
