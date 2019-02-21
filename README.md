# MovieGuru
## About MovieGuru
MovieGuru is a professional-grade movie review site built for the TCI coding challenge.

### Features
* Gets movies from The Movie Database
* Allows users to add ratings to movies in the database
* So much more!

## Setup
First, clone this repository, then install its dependencies by executing:
```bash
bundle install
```

Next up, set up the database by running
```bash
rake db:migrate
```

Next, add your API key by creating the file `config/initializers/tmdb.rb` and adding one line with your API key:
```ruby
Tmdb::Api.key("YOUR API KEY HERE")
```

Finally, start the application:
```bash
rails s
```