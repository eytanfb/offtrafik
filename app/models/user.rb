# == Schema Information
#
# Table name: users
#
#  id                             :integer          not null, primary key
#  email                          :string(255)      default(""), not null
#  encrypted_password             :string(255)      default(""), not null
#  reset_password_token           :string(255)
#  reset_password_sent_at         :datetime
#  remember_created_at            :datetime
#  sign_in_count                  :integer          default(0), not null
#  current_sign_in_at             :datetime
#  last_sign_in_at                :datetime
#  current_sign_in_ip             :string(255)
#  last_sign_in_ip                :string(255)
#  agreed_to_terms_and_conditions :boolean
#  trip_rating                    :integer
#  summary                        :string(255)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  neighborhood                   :string(255)
#  confirmation_token             :string(255)
#  confirmed_at                   :datetime
#  confirmation_sent_at           :datetime
#  first_name                     :string(255)
#  last_name                      :string(255)
#  unconfirmed_email              :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :summary, :neighborhood, :first_name, :last_name, :agreed_to_terms_and_conditions
  
  validates_presence_of :first_name, :last_name, :email, :password, :password_confirmation, message: "alani bos olamaz"
  validates_inclusion_of :agreed_to_terms_and_conditions, in: [true], on: :create
  validates_length_of :password, within: 6..20, on: :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@ku.edu.tr/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  has_many :postings
  has_many :comments
  has_many :favorites
  
  def calculate_rating
    comments_sum = Comment.find_all_by_is_about(self.id).collect { |comment| comment.rating }.sum
    total_comments = Comment.find_all_by_is_about(self.id).count
    if total_comments > 0
      self.trip_rating = comments_sum / total_comments
    else
      0
    end
  end
  
  def self.count
    User.all.count
  end
  
end
