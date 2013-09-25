# encoding: utf-8
# == Schema Information
#
# Table name: postings
#
#  id            :integer          not null, primary key
#  from_address  :string(255)
#  to_address    :string(255)
#  user_id       :integer
#  date          :date
#  starting_time :time
#  ending_time   :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  comments      :text
#  smoking       :boolean
#  driving       :string(255)
#

#!/bin/env ruby
class Posting < ActiveRecord::Base
  attr_accessible :date, :ending_time, :from_address, :starting_time, :to_address, :comments, :smoking, :driving
  attr_writer :current_step
  
  belongs_to :user
  
  validates_presence_of :user_id, :from_address, :to_address, :date, :starting_time, :ending_time
  validates_inclusion_of :driving, :in => %w(Sürücü Yolcu Farketmez Taksi)
  validate :ending_time_is_later_than_starting_time?
  
  default_scope order: 'postings.date ASC'
  
  scope :active, lambda { where('date >= ?', Time.now) }
  scope :live_postings, lambda { where("date >= ?", Date.today) }
  scope :past_postings, lambda { where("date < ?", Date.today) }
  
  def self.search(from_address, to_address, driving)
    if from_address && to_address
      where 'from_address LIKE ? AND to_address LIKE ?', "%#{from_address}%", "%#{to_address}%"
      if driving
        where 'from_address LIKE ? AND to_address LIKE ? and driving LIKE ?', "%#{from_address}%", "%#{to_address}%", "%#{driving}%"
      end
    else
      where "from_address LIKE '%%' AND to_address LIKE '%%'"
    end
  end
  
  def smoking?
    self.smoking ? 'Evet' : 'Hayır'
  end
  
  def active?
    self.date >= Time.current.to_date
  end
  
  def formatted_date
    self.date.strftime("%b %d")
  end
  
  def format(address)
    address.chomp(", Istanbul")
  end
  
  private
    def ending_time_is_later_than_starting_time?
      if self.starting_time && self.ending_time
        errors.add(:starting_time, "Baslangıç zamanı bitiş zamanından daha önce olmalı") unless self.starting_time < self.ending_time
      end
    end
  
end
