# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  name                      :string(255)
#  email                     :string(255)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  password_digest           :string(255)
#  remember_token            :string(255)
#  admin                     :boolean          default(FALSE)
#  driver_rating             :integer
#  person_rating             :integer
#  preferred_contact_method  :string(255)
#  preferred_contact_content :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :driver_rating, :person_rating, 
    :preferred_contact_method, :preferred_contact_content
  has_secure_password
  has_many :postings
  
  before_save :before_save_stuff
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :driver_rating, numericality: { less_than_or_equal_to: 5 }, allow_nil: true
  validates :person_rating, numericality: { less_than_or_equal_to: 5 }, allow_nil: true
  validates_inclusion_of :preferred_contact_method, in: %w[email phone bbm]
  validates :preferred_contact_content, presence: true, format: { with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false },
  if: lambda { |user| user.preferred_contact_method == 'email' }
  VALID_PHONE_REGEX = /05\d{9}/
  validates :preferred_contact_content, presence: true, format: { with: VALID_PHONE_REGEX}, 
  if: lambda { |user| user.preferred_contact_method == 'phone' }
  VALID_BBM_REGEX = /[0-9A-F]{8}/
  validates :preferred_contact_content, presence: true, format: { with: VALID_BBM_REGEX}, 
  if: lambda { |user| user.preferred_contact_method == 'bbm' }
  
  def live_postings
    self.postings.select { |posting| posting.date > Date.today }
  end
  
  def past_postings
    self.postings.select { |posting| posting.date < Date.today }
  end
  
  private
    def before_save_stuff
      self.remember_token = SecureRandom.urlsafe_base64
      self.driver_rating ||= 0
      self.person_rating ||= 0
      if self.preferred_contact_method == 'email'
        self.preferred_contact_content ||= self.email
      end
    end
end
