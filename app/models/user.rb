# == Schema Information
#
# Table name: users
#
#  id                             :integer          not null, primary key
#  name                           :string(255)
#  email                          :string(255)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  password_digest                :string(255)
#  remember_token                 :string(255)
#  admin                          :boolean          default(FALSE)
#  preferred_contact_method       :string(255)
#  preferred_contact_content      :string(255)
#  agreed_to_terms_and_conditions :boolean
#  trip_rating                    :integer
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :preferred_contact_method, 
    :preferred_contact_content, :agreed_to_terms_and_conditions, :trip_rating
  has_secure_password
  has_many :postings
  has_many :comments
  
  before_save :before_save_stuff
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@ku.edu.tr/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :trip_rating, numericality: { less_than_or_equal_to: 5 }, allow_nil: true
  validates_inclusion_of :preferred_contact_method, in: %w[email phone bbm]
  validates :preferred_contact_content, presence: true, format: { with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false },
  if: lambda { |user| user.preferred_contact_method == 'email' }
  VALID_PHONE_REGEX = /05\d{9}/
  validates :preferred_contact_content, presence: true, format: { with: VALID_PHONE_REGEX}, 
  if: lambda { |user| user.preferred_contact_method == 'phone' }
  VALID_BBM_REGEX = /[0-9A-F]{8}/
  validates :preferred_contact_content, presence: true, format: { with: VALID_BBM_REGEX}, 
  if: lambda { |user| user.preferred_contact_method == 'bbm' }
  validates_inclusion_of :agreed_to_terms_and_conditions, in: [true]
  
  def live_postings
    self.postings.select { |posting| posting.date >= Date.today }
  end
  
  def past_postings
    self.postings.select { |posting| posting.date < Date.today }
  end
  
  def calculate_rating
    comments_sum = Comment.find_all_by_is_about(self.id).collect { |comment| comment.rating }.sum
    total_comments = Comment.find_all_by_is_about(self.id).count
    if total_comments > 0
      self.trip_rating = comments_sum / total_comments
    end
  end
  
  private
    def before_save_stuff
      self.remember_token = SecureRandom.urlsafe_base64
      self.trip_rating ||= 0
      if self.preferred_contact_method == 'email'
        self.preferred_contact_content ||= self.email
      end
    end
end
