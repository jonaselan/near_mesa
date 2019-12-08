class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :comments
  has_many :ratings
  has_many :locations

  def generate_jwt
    JWT.encode({ id: id,
                 exp: 60.days.from_now.to_i },
               Rails.application.secrets.secret_key_base)
  end
end
