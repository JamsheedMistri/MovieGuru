class ReviewsController < ApplicationController
  # Show all reviews
  def show
    # Get all review objects
    @review_objects = Review.all

    # Convert array of reviews to array of hashes with corresponding review data (so we can modify before sending to view)
    @reviews = []
    @review_objects.each do |object|
      @reviews.push(object.attributes)
    end

    # For each review, find the movie it belongs to and add a reference to it in the hash
    @reviews.each do |review|
      review["movie_obj"] = Tmdb::Movie.detail(review["movie"])
    end

    # Before sending reviews to the view, ensure that the newest display first
    @reviews.reverse!
  end
  
  # Create a new review
  def new
    # Get the movie object that corresponds to the new review form for displaying on the view
    @movie = Tmdb::Movie.detail(params[:id])

    # Leave a title corresponding to the movie title being reviewed
    @title = "Leave a Review | " + @movie.title

    # If there are any errors from the previous attempt, send them to the view
    @errors = session[:errors]
    session[:errors] = nil
  end

  # Post method to create a review from the new review form
  def create
    # Get the permitted parameters using this helper method
    review_params = raw_params

    # Add the movie ID and the date to the new review before creating it
    review_params[:movie] = params[:id]
    review_params[:date] = DateTime.now.strftime('%Y-%m-%d')

    # Create the new review based on the hash
    @review = Review.new(review_params)

    # Attempt to save the review
    if (@review.save)
      # If the review saves successfully, redirect to the movie that it reviewed
      redirect_to show_movie_path(params[:id])
    else
      # If the review did not save successfully, send the error messages to the form again
      session[:errors] = @review.errors.full_messages
      redirect_to new_review_path(params[:id])
    end
  end

  # Private helper method to get permitted parameters for a new review
  private def raw_params
    params.require(:review).permit(:email, :rating, :comment)
  end
end
