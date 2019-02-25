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

Next up, set up the database by running:
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

## Testing
In order to prepare the database for testing, execute the following command:
```bash
rails db:test:prepare
```

Finally, test the reviews model using the custom cases:
```bash
rails test test/models/review_test.rb
```

## Files Submitted
* Assets (**app/assets**)
	* Master stylesheet (**stylesheets/application.scss**)
* Controllers (**app/controllers**)
	* Pages controller (**pages_controller.rb**)
	* Movies controller (**movies_controller.rb**)
	* Reviews controller (**reviews_controller.rb**)
* Helpers (**app/helpers**)
	* Application helper (**application_helper.rb**)
* Models (**app/models**)
	* Review model (**review.rb**)
* Views (**app/views**)
	* Main layout (**layouts/application.html.erb**)
	* Movie list (**movies/list.html.erb**)
	* Show specific movie (**movie/show.html.erb**)
	* About (**pages/about.html.erb**)
	* Index (**pages/index.html.erb**)
	* New review (**reviews/new.html.erb**)
	* Show all reviews (**show.html.erb**)
* Public (**public**)
	* Favicon (**favicon.ico**)
	* Apple touch icon (**apple-touch-icon.png**)
	* Precomposed Apple touch icon (**apple-touch-icon-precomposed.png**)