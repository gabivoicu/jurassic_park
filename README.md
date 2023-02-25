### The Stack - Server
- Language
  - Ruby 3.1.0
  - Rails 6

## Development Getting Started

    # Clone and setup repo
    git clone git@github.com:gabivoicu/jurassic_park.git
    cd jurassic_park

    # Install and setup server dependencies
    bundle install
    bundle exec rake db:create db:migrate

## Run it

    # Backend (http://localhost:3000)
    rails s

## Test It

    # Setup test DB for testing
    bundle exec rake db:migrate RAILS_ENV=test

    # Run tests
    bundle exec rspec

Manual testing can be done with a tool like [Postman](https://www.postman.com/downloads/).

## Lint It

    bundle exec rubocop

### On Challenge completion

I ran out of time to add controller tests (but I tested all endpoints with Postman). 

### Concurrent environment

To use this app in a production environment I would:
- containerize using something like Docker and deploy multiple instances
- use AWS/Heroku to set up automated scaling and deploys where containers are replaced one after the other for stability
- set up load balancer
- use Parameter Store for safe storage and sharing across instances of environment variables
- I would add authentication so that the API can only be accessed by authorized users

### Additional thoughts
- It would be useful to add a `max_capacity` value for Cages
