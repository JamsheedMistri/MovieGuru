class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Review < ApplicationRecord
	validates :movie, :date, presence: true
	validates :rating, numericality: { only_integer: true }
	validates :email, presence: true, email: true
	validates :comment, length: { maximum: 250 }
end