# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  text       :string(255)
#  rating     :integer
#  is_about   :integer
#  user_id    :integer
#

class Comment < ActiveRecord::Base
  attr_accessible :text, :rating, :is_about
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  default_scope order: 'comments.created_at DESC'
  
  after_save :update_user_rating
  
  validates_presence_of :text, :rating, :is_about
  validates_length_of :text, within: 0..140
  validates_numericality_of :rating, greater_than_or_equal_to: 0, 
    less_than_or_equal_to: 5, only_integer: true
  validates_numericality_of :is_about, only_integer: true
  validates_inclusion_of :is_about, in: 0...6 # in: User.all.select { |user| user.postings.count > 0 }.collect { |user| user.id }
  
  private
    def update_user_rating
      user = User.find(self.is_about)
      user.trip_rating = (Comment.find_all_by_is_about(self.is_about).collect { |comment| comment.rating }.sum) / 
        Comment.find_all_by_is_about(self.is_about).count
    end
end