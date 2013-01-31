# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  car_id     :integer
#

class Person < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :car_id
  has_one :car
end
