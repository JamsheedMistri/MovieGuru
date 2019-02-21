# Email validator, code courtesy of the Ruby validator API docs
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Review < ApplicationRecord
	# The corresponding movie and date must be present
	validates :movie, :date, presence: true
	# The rating must be an integer
	validates :rating, numericality: { only_integer: true }
	# The email must be present and must be a valid email
	validates :email, presence: true, email: true
	# The comment must be no longer than 250 characters
	validates :comment, length: { maximum: 250 }
end