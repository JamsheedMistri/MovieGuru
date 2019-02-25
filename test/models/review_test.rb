require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  test "should not save review with no fields" do
  	review = Review.new
    assert_not review.save, "Saved review with no fields"
  end

  test "should not save review with no movie" do
  	review = Review.new({
  		movie: nil,
  		date: "2019-02-25",
  		rating: 4,
  		email: "jmistri7@gmail.com",
  		comment: "Test comment!"
  	})
  	assert_not review.save, "Saved review with no movie"
  end

  test "should not save review with string movie" do
  	review = Review.new({
  		movie: "strings are invalid!",
  		date: "2019-02-25",
  		rating: 4,
  		email: "jmistri7@gmail.com",
  		comment: "Test comment!"
  	})
  	assert_not review.save, "Saved review with movie string"
  end

  test "should not save review with no date" do
  	review = Review.new({
  		movie: 399579,
  		date: nil,
  		rating: 4,
  		email: "jmistri7@gmail.com",
  		comment: "Test comment!"
  	})
  	assert_not review.save, "Saved review with no date"
  end

  test "should not save review with rating less than 1" do
  	review = Review.new({
  		movie: 399579,
  		date: "2019-02-25",
  		rating: -1,
  		email: "jmistri7@gmail.com",
  		comment: "Test comment!"
  	})
  	assert_not review.save, "Saved review with rating less than 1"
  end

  test "should not save review with rating greater than 5" do
  	review = Review.new({
  		movie: 399579,
  		date: "2019-02-25",
  		rating: 999,
  		email: "jmistri7@gmail.com",
  		comment: "Test comment!"
  	})
  	assert_not review.save, "Saved review with rating greater than 5"
  end

  test "should not save review with invalid email" do
  	review = Review.new({
  		movie: 399579,
  		date: "2019-02-25",
  		rating: 4,
  		email: "this string isn't an email",
  		comment: "Test comment!"
  	})
  	assert_not review.save, "Saved review with invalid email"
  end

  test "should not save review with no email" do
  	review = Review.new({
  		movie: 399579,
  		date: "2019-02-25",
  		rating: 4,
  		email: nil,
  		comment: "Test comment!"
  	})
  	assert_not review.save, "Saved review with no email"
  end

  test "should save review with no comment" do
  	review = Review.new({
  		movie: 399579,
  		date: "2019-02-25",
  		rating: 4,
  		email: "jmistri7@gmail.com",
  		comment: nil
  	})
  	assert review.save, "Did not save review with no comment"
  end

  test "should save review with empty comment" do
  	review = Review.new({
  		movie: 399579,
  		date: "2019-02-25",
  		rating: 4,
  		email: "jmistri7@gmail.com",
  		comment: ""
  	})
  	assert review.save, "Did not save review with empty comment"
  end

  test "should not save review with comment that is 251 characters" do
  	review = Review.new({
  		movie: 399579,
  		date: "2019-02-25",
  		rating: 4,
  		email: "jmistri7@gmail.com",
  		comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dol"
  	})
  	assert_not review.save, "Saved review with comment that is 251 characters"
  end
end
