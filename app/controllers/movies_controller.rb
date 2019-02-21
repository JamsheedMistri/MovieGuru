class MoviesController < ApplicationController
  # List all movies
  def list
    # Set title for page
    @title = "Movies"

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

      # For each movie, get the last 5 reviews and add it as an attribute for displaying in the view
      movie.reviews = Review.where(movie: movie.id).limit(5)
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
  end

  # Show specific movie
  def show
    # Get the movie given an ID using the TMDb API
    @movie = Tmdb::Movie.detail(params[:id])
    @movie.reviews = Review.where(movie: @movie.id)

    # Set the title to the corresponding movie's title
    @title = @movie.title
  end
end
