# Example Q&A web application

## What is this?

This is an example Q&A web application written using Ruby's [Roda](https://roda.jeremyevans.net/) web framework with [Sequel](https://sequel.jeremyevans.net/).


## Setup

- Ensure you have at least `ruby 3.1.0` installed
- Pull the repo
- Run `bundle install`
- Run `rake dev_up` to create the development sqlite3 database
- Run `rake seed` to populate the development database with some basic data
- Run `rackup` and navigate to [http://localhost:9292](http://localhost:9292)
- User login is "stubbed" with dummy accounts (from the seed) to avoid complexity


## Running Tests

- Run `RACK_ENV=test rake test_up`
- Run `rspec` to run full set of specs
