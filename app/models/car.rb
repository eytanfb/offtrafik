# encoding: utf-8
# == Schema Information
#
# Table name: cars
#
#  id         :integer          not null, primary key
#  capacity   :integer
#  smoking    :boolean
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

#!/bin/env ruby

class Car < ActiveRecord::Base
  attr_accessible :capacity, :smoking
  
  validates :user_id, presence: true
  validates :capacity, presence: true, numericality: { less_than_or_equal_to: 4, only_integer: true}
  
  belongs_to :user

end
