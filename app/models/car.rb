# == Schema Information
#
# Table name: cars
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  capacity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Car < ActiveRecord::Base
  attr_accessible :capacity, :person_id
  belongs_to :person
end
