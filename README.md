# Ruby backend
Rewritten backend in a Ruby on rails framework.

## Running the app
First, install all the dependencies, from the api_servis run:
```
bundle install
sudo bundle install           # for macs
```

To start the app, run `rails server` from api_servis and auth_servis.

## Database

### Using mysql2
If you are not using a macbook, there shouldn't be any problems. For macbook users, install mysql2 with following commands:
```
sudo gem install mysql2 -- --with-opt-dir=/opt/homebrew/opt/openssl@3 --with-mysql-dir=/opt/homebrew/opt/mysql
gem list mysql2     # check if it is installed
```

Start the mysql server, you can do it through [XAMPP](https://www.apachefriends.org/download.html) (manager-osx for macs). 

### Using sqlite 
If you wish to see the database, from api_servis run:
```
sqlite3

# Then, in the SQLite shell:
.open ../db/cvecara.sqlite
.tables                         # lists tables
.schema                         # db schema
.exit                           # exit

# Run SQL commands as usual:
SELECT * FROM Kategorija;
SELECT * FROM Korisnik;
```

### Deployment 
Run the following commands from the api_servis: <br>
```
rails db:create
rails db:migrate
rails db:seed
```

For the test database add `RAILS_ENV=test` to the end of every command.

If you wish to reroll a migration:
```
rails db:rollback            # one migration
rails db:rollback STEP=n     # n migrations
rails db:drop                # drop all tables
```

## Testing
To run the tests, run `rails test`.
Reload the testing database with `rails db:test:prepare`.