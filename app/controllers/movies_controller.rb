class MoviesController < ApplicationController
	def list
		@title = "Movies"
		@movies = Tmdb::Movie.popular.results
		all_genres = Tmdb::Genre.movie_list
		@movies.each do |movie|
			movie.genres = []
			movie.genre_ids.each do |movie_genre|
				movie.genres.push(all_genres.detect { |genre|
					genre.id == movie_genre
				})
			end

			movie.reviews = Review.where(:movie => movie.id).limit(5)
		end

		if params[:sort] == "title"
			@movies = @movies.sort_by &:title
		elsif params[:sort] == "release_date" 
			@movies = @movies.sort_by &:release_date
		elsif params[:sort] == "genre" 
			@movies = @movies.sort_by &:genre
		end
	end

	def show
		@movie = Tmdb::Movie.detail(params[:id])
		@movie.reviews = Review.where(:movie => @movie.id)
		@title = @movie.title
	end
end
