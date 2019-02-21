class PagesController < ApplicationController
	def index
		@movies = Tmdb::Movie.popular.results
		all_genres = Tmdb::Genre.movie_list
		@movies.each do |movie|
			movie.genres = []
			movie.genre_ids.each do |movie_genre|
				movie.genres.push(all_genres.detect { |genre|
					genre.id == movie_genre
				})
			end

			movie.reviews = Review.where(:movie => movie.id).limit(2)
		end

		if params[:sort] == "title"
			@movies = @movies.sort_by &:title
		elsif params[:sort] == "release_date" 
			@movies = @movies.sort_by &:release_date
		elsif params[:sort] == "genre" 
			@movies = @movies.sort_by &:genre
		end

		@recent_reviews = Review.last(3)
		@recent_reviews.reverse!

		@recent_movies = @movies.reverse.first(3)
	end

	def about
		@title = "About"
	end
end
