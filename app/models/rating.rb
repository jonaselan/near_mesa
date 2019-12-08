class Rating < ApplicationRecord
  belongs_to :location
  belongs_to :user

  validates_presence_of :value
  validates_numericality_of :value, greater_than: 0, less_than_or_equal_to: 10
end
