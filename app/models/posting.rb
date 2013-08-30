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
#  longitude     :float
#  latitude      :float
#  gmaps         :boolean
#  comments      :text
#  smoking       :boolean
#  driving       :string(255)
#

#!/bin/env ruby
class Posting < ActiveRecord::Base
  attr_accessible :date, :ending_time, :from_address, :starting_time, :to_address, :longitude, :latitude, :gmaps, 
    :comments, :smoking, :driving
  attr_writer :current_step
  
  belongs_to :user
  
  validates_presence_of :user_id, :from_address, :to_address, :date, :starting_time, :ending_time
  validates_inclusion_of :driving, :in => %w(Sürücü Yolcu Farketmez)
  validate :ending_time_is_later_than_starting_time?
  
  default_scope order: 'postings.date ASC'
  
  scope :active, lambda { where('date >= ?', Time.now) }
  
  def self.search(from_address, to_address, date, driving)
    if from_address && to_address && date
      where 'from_address LIKE ? AND to_address LIKE ? and date >= ?', "%#{from_address}%", "%#{to_address}%", date
      if driving
        where 'from_address LIKE ? AND to_address LIKE ? and date >= ? and driving LIKE ?', "%#{from_address}%", "%#{to_address}%", date, "%#{driving}%"
      end
    else
      where "from_address LIKE '%%' AND to_address LIKE '%%' and date >= ?", Date.today
    end
  end
  
  def smoking?
    self.smoking ? 'Evet' : 'Hayır'
  end
  
  private
    def ending_time_is_later_than_starting_time?
      if self.starting_time && self.ending_time
        errors.add(:starting_time, "Baslangic zamani bitis zamanindan daha once olmali") unless self.starting_time < self.ending_time
      end
    end
  
end
