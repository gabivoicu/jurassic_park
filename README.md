### The Stack - Server
- Language
  - Ruby 3.1.0
  - Rails 6
  - SQLite

## Development Getting Started

    # Clone and setup repo
    git clone git@github.com:gabivoicu/jurassic_park.git
    cd jurassic_park

    # Install and setup server dependencies
    bundle install
    bundle exec rake db:create db:migrate

## Run it

    # Backend (http://localhost:3000)
    bin/rails s

## Test It

    # Setup test DB for testing
    bundle exec rake db:migrate RAILS_ENV=test

    # Run tests
    bundle exec rspec

Manual testing can be done with a tool like [Postman](https://www.postman.com/downloads/).
Sample payload:

    # POST http://localhost:3000/api/v1/dinosaurs
    {
        "dinosaur": {
            "name": "Dino 4",
            "species": "Brachiosaurus"
        }
    }
    # will return 200; removing either key will return a 400 with appropriate message error

    # POST http://localhost:3000/api/v1/cages
    {
        "cage": {
            "max_capacity": 15,
            "dinosaurs": [1,2]
        }
    }
    # will return 200 if 2 dinosaurs were created before

## Lint It

    bundle exec rubocop

### On Challenge completion

I ran out of time to add controller tests (but I tested all endpoints with Postman). 

### Concurrent environment

To use this app in a production environment I would:
- containerize using something like Docker and deploy multiple instances
- use Heroku with a Rails builpack and the Heroku CLI, run more dynos via their autoscaling to meed load requirements
- load balancer handled by Heroku
- environment variables storage on Heroku
- switch to Postgres or MySQL database 
- I would add authentication so that the API can only be accessed by authorized users

### Additional thoughts
- In a work environment, I would have worked off a branch for the changes but I thought for a interview assignment working on `main` is acceptable.