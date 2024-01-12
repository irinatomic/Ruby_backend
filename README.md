# Ruby_backend
Rewritten express backend in a Ruby on rails framework.

## Running the app
Creating a rails api app: `rails new app-name --api`. <br>

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

If you wish to see the database, from api_servis run:
```
sqlite3

# Then, in the SQLite shell:
.open cvecara.sqlite
.tables                         # lists tables
.schema                         # db schema
.exit                           # exit

# Run SQL commands as usual:
SELECT * FROM Categories;
SELECT * FROM Users;
```