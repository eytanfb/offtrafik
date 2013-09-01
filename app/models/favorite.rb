# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  location   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Favorite < ActiveRecord::Base
  
  attr_accessible :user_id, :location
  
  validates_presence_of :user_id, :location
  
  belongs_to :user
  
end
