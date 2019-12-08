class User < ApplicationRecord
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable

  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :reviews
  has_many :locations
end
