# Ruby backend
Rewritten backend in a Ruby on rails framework.

## Running the app
First, install all the dependencies, from the api_servis run:
```
bundle install
sudo bundle install           # for macs
```

To start the app, run `rails server`

## Database

### Problem with macbook m1
Installing the mysql2 on macbook m1 (with brew):
```
brew install mysql openssl zstd
sudo gem install mysql2 -- --with-opt-dir=/opt/homebrew/opt/openssl@3 --with-mysql-dir=/opt/homebrew/opt/mysql

# check if it is installed
gem list mysql2
```

Start the mysql server, for macs you can do it with:
```
brew services start mysql

# check if it is running
brew services list
```

The problem is that the started mysql serves just unexpectedly shuts down or  it cannot be found on the port it says it is listening on. I do not know the solution to this so I am opting to use the sqlite in-app db instead.

### Deployment 

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

## Testing
To run the tests, run `rails test`