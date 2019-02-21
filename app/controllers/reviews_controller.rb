class ReviewsController < ApplicationController
	def show
		@review_objects = Review.all
		@reviews = []
		@review_objects.each do |object|
			@reviews.push(object.attributes)
		end
		@reviews.each do |review|
			logger.debug review
			review["movie_obj"] = Tmdb::Movie.detail(review["movie"])
		end
		@reviews.reverse!
	end
	
	def new
		@movie = Tmdb::Movie.detail(params[:id])
		@title = "Leave a Review | " + @movie.title

		@errors = session[:errors]
  		session[:errors] = nil
	end

	def create
		review_params = raw_params
		review_params[:movie] = params[:id]
		review_params[:date] = DateTime.now.strftime('%Y-%m-%d')
		@review = Review.new(review_params)

		if (@review.save)
			redirect_to show_movie_path(params[:id])
		else
  			session[:errors] = @review.errors.full_messages
			redirect_to new_review_path(params[:id])
		end
	end

	private def raw_params
		params.require(:review).permit(:email, :rating, :comment)
	end
end
