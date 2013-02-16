class Posting < ActiveRecord::Base
  attr_accessible :date, :ending_time, :from_address, :price, :starting_time, :to_address
  
  belongs_to :user
  
  validates_presence_of :user_id, :from_address, :to_address, :price, :starting_time, :ending_time
  validate :ending_time_is_later_than_starting_time?
  
  private
  def ending_time_is_later_than_starting_time?
    errors.add(:starting_time, "bitis zamanindan daha once olmali") unless self.starting_time < self.ending_time
  end
  
end
