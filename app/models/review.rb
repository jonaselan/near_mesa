class Review < ApplicationRecord
  belongs_to :location
  belongs_to :user

  validates_presence_of :comment
  validates_presence_of :rating
  validates_numericality_of :rating, greater_than: 0, less_than_or_equal_to: 10
end
