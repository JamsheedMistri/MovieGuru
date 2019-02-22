class PagesController < ApplicationController
  # Show movies and latest reviews on index
  def index
    # Generate list of popular movies to send to list page
    @movies = Tmdb::Movie.popular.results

    # Movies list doesn't have genres, only genre IDs, so we must manually add the genres to the object before sending it to the view
    all_genres = Tmdb::Genre.movie_list
    @movies.each do |movie|
      # For each movie, create an attribute called "genres" and add all corresponding genre objects
      movie.genres = []
      movie.genre_ids.each do |movie_genre|
        movie.genres.push(all_genres.detect { |genre|
          genre.id == movie_genre
        })
      end

      # For each movie, get the last 2 reviews and add it as an attribute for displaying in the view
      movie.reviews = Review.where(movie: movie.id).limit(2)
    end

    # Check for sorting request and sort movies if necessary
    if params[:sort] == "title"
      @movies = @movies.sort_by &:title
    elsif params[:sort] == "release_date" 
      @movies = @movies.sort_by &:release_date
      @movies.reverse!
    elsif params[:sort] == "genre" 
      # Since there are multiple genres for each movie, sort by the mail genre
      @movies = @movies.sort_by { |movie| movie.genres[0].name }
    end

    # Send the latest 3 reviews to the view
    @recent_review_objects = Review.last(3)

    # Convert array of reviews to array of hashes with corresponding review data (so we can modify before sending to view)
    @recent_reviews = []
    @recent_review_objects.each do |object|
      @recent_reviews.push(object.attributes)
    end

    @recent_reviews.reverse!
    @recent_reviews.each do |review|
      review["movie_obj"] = Tmdb::Movie.detail(review["movie"])
    end

    # Send the latest 3 movies to the view
    @recent_movies = (@movies.sort_by &:release_date).reverse.first(3)
  end

  # Static about page
  def about
    # All content is static on the about page, so the only thing that is needed is this title
    @title = "About"
  end
end
