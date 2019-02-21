module ApplicationHelper
  def cp(path)
    "active" if current_page?(path)
  end

  def active(sort)
    if (sort == "none" && (params[:sort] == "none" || params[:sort] == nil)) || params[:sort] == sort
      "active"
    else
      ""
    end
  end

  def average_rating(movie)
  	reviews = Review.where(:movie => movie.id)
    return 0 if reviews.length == 0
  	sum = 0
  	reviews.each do |review|
  		sum += review.rating
  	end
    return (sum.to_f / reviews.length.to_f).round
  end

  def print_average_rating(movie)
    return print_rating(average_rating(movie))
  end

  def print_rating(rating)
    string = "".html_safe
    5.times do |x|
      string += x < rating ? '<i class="fa fa-star"></i>'.html_safe : '<i class="fa fa-star-o"></i>'.html_safe
    end
    return string
  end

  $images_url = Tmdb::Configuration.get.images.secure_base_url + "w780"
end