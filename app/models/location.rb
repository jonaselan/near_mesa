class Location < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :latitude, scope: :longitude

  belongs_to :user
end
