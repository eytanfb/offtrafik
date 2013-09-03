# == Schema Information
#
# Table name: neighborhoods
#
#  id          :integer          not null, primary key
#  district_id :integer
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Neighborhood < ActiveRecord::Base
  
  attr_accessible :disctrict_id, :name
  
  belongs_to :district
  
end
