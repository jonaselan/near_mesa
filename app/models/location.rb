class Location < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :latitude, scope: :longitude

  belongs_to :user

  scope :near, lambda { |lat, lng|
    find_by_sql(["
      SELECT *, ( 6371 * acos( cos( radians(?) ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians(?) ) + sin( radians(?) ) * sin( radians( latitude ) ) ) ) AS distance
      FROM locations
      ORDER BY distance asc
    ", lng, lat, lng])
  }
end
