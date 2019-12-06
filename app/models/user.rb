class User < ApplicationRecord
  validates_presence_of :username, :email
  validates_uniqueness_of :email

  has_many :comments
  has_many :locations
end
