# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  driver_rating   :integer
#  person_rating   :integer
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :driver_rating, :person_rating
  has_secure_password
  has_many :cars
  
  before_save :before_save_stuff
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :driver_rating, numericality: { less_than_or_equal_to: 5 }
  validates :person_rating, numericality: { less_than_or_equal_to: 5 }
  
  private
    def before_save_stuff
      self.remember_token = SecureRandom.urlsafe_base64
      self.driver_rating = 0
      self.person_rating = 0
    end
end
