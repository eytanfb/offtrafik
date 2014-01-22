# == Schema Information
#
# Table name: frequent_days
#
#  id                  :integer          not null, primary key
#  day                 :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  frequent_posting_id :integer
#

class FrequentDay < ActiveRecord::Base
  attr_accessible :day
  
  validates_inclusion_of :day, in: %w(monday tuesday wednesday thursday friday saturday sunday)
  
  belongs_to :frequent_posting
end
