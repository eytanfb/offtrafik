# encoding: utf-8
# == Schema Information
#
# Table name: frequent_postings
#
#  id            :integer          not null, primary key
#  last_date     :date
#  from_address  :string(255)
#  to_address    :string(255)
#  smoking       :boolean
#  comments      :text
#  driving       :string(255)
#  starting_time :time
#  ending_time   :time
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class FrequentPosting < ActiveRecord::Base

  attr_accessible :comments, :driving, :ending_time, :from_address, :last_date, :smoking, :starting_time, :to_address
  
  belongs_to :user
  
  validates_presence_of :user_id, :from_address, :to_address, :last_date, :starting_time, :ending_time
  validates_inclusion_of :driving, in: %w(Sürücü Yolcu Farketmez Taksi)
  validate :ending_time_is_later_than_starting_time?

  has_many :frequent_days
  
  private
    def ending_time_is_later_than_starting_time?
      if self.starting_time && self.ending_time
        errors.add(:starting_time, "Baslangıç zamanı bitiş zamanından daha önce olmalı") unless self.starting_time < self.ending_time
      end
    end
  
end
