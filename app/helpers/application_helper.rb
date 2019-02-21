module ApplicationHelper
  # Return "active" for the current page for the navbar class
  def cp(path)
    "active" if current_page?(path)
  end

  # Return "active" for the current sort method for the sort pagination
  def active(sort)
    ((sort == "none" && (params[:sort] == "none" || params[:sort] == nil)) || params[:sort] == sort) ? "active" : ""
  end

  # Get the average rating for a movie object
  def average_rating(movie)
    # Get all reviews that correspond to the provided movie
  	reviews = Review.where(movie: movie.id)

    # If the movie has no reviews yet, give it a 0 star rating
    return 0 if reviews.length == 0

    # Sum all reviews and divide by the amount of reviews to get the average
  	sum = 0
  	reviews.each do |review|
  		sum += review.rating
  	end
    return (sum.to_f / reviews.length.to_f).round
  end

  # Print the average rating using 2 helper methods
  def print_average_rating(movie)
    return print_rating(average_rating(movie))
  end

  # Print the rating for a given number out of 5 stars using Font Awesome icons
  def print_rating(rating)
    string = "".html_safe
    5.times do |x|
      string += x < rating ? '<i class="fa fa-star"></i>'.html_safe : '<i class="fa fa-star-o"></i>'.html_safe
    end
    return string
  end

  # Format dates to the style we want
  def format_date(date_string)
    Date.strptime(date_string, '%Y-%m-%d').strftime("%b %d, %Y")
  end

  # Provide a global configuration image base
  $images_url = Tmdb::Configuration.get.images.secure_base_url + "w780"
end