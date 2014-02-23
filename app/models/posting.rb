# encoding: utf-8
# == Schema Information
#
# Table name: postings
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  date          :date
#  starting_time :time
#  ending_time   :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  comments      :text
#  smoking       :boolean
#  driving       :string(255)
#  from_address  :string(255)
#  to_address    :string(255)
#

#!/bin/env ruby
class Posting < ActiveRecord::Base
  attr_accessible :date, :ending_time, :from_address, :starting_time, :to_address, :comments, :smoking, :driving
  
  belongs_to :user
  has_many :posting_responses, :class_name => "PostingResponse", :foreign_key => "posting_id", dependent: :destroy
  
  before_validation :change_taxi_sharing_to_taxi
  
  validates_presence_of :from_address, :to_address, :date, :starting_time, :ending_time, :user_id
  validates_inclusion_of :driving, in: %w(Sürücü Yolcu Taksi)
  validate :ending_time_is_later_than_starting_time?
  
  default_scope order: 'postings.date ASC'
  
  scope :live_postings,       lambda { where("date >= ?", Date.today) }
  scope :past_postings,       lambda { where("date < ?", Date.today) }
  scope :with_from_address,   lambda { |value| where("from_address LIKE ? and from_address LIKE ?", "%#{Posting.format(value)}%", "%#{(value.split & (DISTRICTS + NEIGHBORHOODS.collect(&:last))).first}%") if value }
  scope :with_to_address,     lambda { |value| where("to_address LIKE ? and to_address LIKE ?", "%#{Posting.format(value)}%", "%#{(value.split & (DISTRICTS + NEIGHBORHOODS.collect(&:last))).first}%") if value }
  scope :with_driving,        lambda { |value| where("driving LIKE ?", "%#{value}%") if value }
  scope :not_current_user,    lambda { |value| where("user_id <> #{value}") if value }
  
  def smoking?
    self.smoking ? 'Evet' : 'Hayır'
  end
  
  def active?
    self.date >= Time.current.to_date
  end
  
  def formatted_date
    self.date.strftime("%b %d")
  end
  
  def self.format(address)
    address = address.chomp(", Turkey")
    address = address.chomp(", Istanbul")
    address = address.chomp(", Istanbul, Turkey")
  end

  def self.count
    Posting.all.count
  end
  
  def from_address_district
    get_partial_address self.to_address, 1
  end
  
  def neighborhood
    get_partial_address self.to_address, 0
  end
    
  def get_partial_address(address, part)
    address.include?('Koç Üniversitesi') ? 'Koç Üniversitesi' : address.split(',')[part] 
  end
  
  def people_who_completed_journey(dont_include_this_name)
    self.posting_responses.map { |response| [response.responder.name, response.posting.user.name] if response.accepted && response.poster_agreed && response.responder_agreed }.flatten.delete_if {|name| (name.nil? || name == dont_include_this_name) }
  end
  
  private
    def ending_time_is_later_than_starting_time?
      if self.starting_time && self.ending_time
        errors.add(:starting_time, "Baslangıç zamanı bitiş zamanından daha önce olmalı") unless self.starting_time < self.ending_time
      end
    end
    
    def change_taxi_sharing_to_taxi
      self.driving = "Taksi" if self.driving == "Taksi Paylasimi"
    end
  
end
