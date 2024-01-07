# Ruby_backend
Rewritten express backend in a Ruby on rails framework.

## Running the app
First, install all the dependencies, from the api_servis run:
```
bundle install
```

## Deploying the database
Run the following commands from the api_servis: <br>
```
rails db:create
rails db:migrate
rails db:seed
```

If you wish to reroll a migration:
```
rails db:rollback            # one migration
rails db:rollback STEP=n     # n migrations
rails db:drop                # drop all tables
```