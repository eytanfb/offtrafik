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
  
  validates_presence_of :user_id
  validates_presence_of :from_address, :to_address, if: lambda { |posting| posting.current_step == "address" }
  validates_presence_of :date, :starting_time, :ending_time, if: lambda { |posting| posting.current_step == "date_time" }
  validates_inclusion_of :driving, :in => %w(Sürücü Yolcu Farketmez)
  validate :ending_time_is_later_than_starting_time?
  
  acts_as_gmappable validate: :validate_both_addresses, msg: 'Verilen adres Google\'da bulunamadi'
  
  default_scope order: 'postings.date ASC'
  
  def current_step
    @current_step || steps.first
  end 
  
  def steps
    %w[driving address date_time comments]
  end
  
  def next_step
    self.current_step = steps[steps.index(current_step) + 1]    
  end
  
  def previous_step
    self.current_step = steps[steps.index(current_step) - 1]
  end
  
  def first_step?
    self.current_step == steps.first
  end
  
  def last_step?
    self.current_step == steps.last
  end
  
  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
  
  def self.search(from_address, to_address, date, driving)
    if from_address && to_address && date
      where 'from_address LIKE ? AND to_address LIKE ? and date >= ?', "%#{from_address}%", "%#{to_address}%", date
      if driving && driving != "Yolculuk Tarzı"
        where 'from_address LIKE ? AND to_address LIKE ? and date >= ? and driving = ?', "%#{from_address}%", "%#{to_address}%", date, driving
      end
    else
      where "from_address LIKE '%%' AND to_address LIKE '%%' and date >= ?", Date.today
    end
  end
  
  def gmaps4rails_address
    "#{from_address} to #{to_address}"
  end
  
  def smoking?
    self.smoking ? 'Evet' : 'Hayır'
  end
  
  private
    def ending_time_is_later_than_starting_time?
      if self.starting_time && self.ending_time
        errors.add(:starting_time, "bitis zamanindan daha once olmali") unless self.starting_time < self.ending_time
      end
    end
    
    def validate_both_addresses
      if Gmaps4rails.geocode(self.from_address) && Gmaps4rails.geocode(self.to_address)
        return true
      else
        return false
      end
    end
  
end
