# == Schema Information
#
# Table name: posting_responses
#
#  id           :integer          not null, primary key
#  responder_id :integer
#  posting_id   :integer
#  accepted     :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PostingResponse < ActiveRecord::Base
  attr_accessible :accepted, :responder_id
  
  belongs_to :posting, :class_name => "Posting", :foreign_key => "posting_id"
  belongs_to :user, :class_name => "User", :foreign_key => "responder_id"
  
  validates :posting_id, :responder_id, presence: true

  scope :past, -> { joins(:posting).where("date < ?", Date.today) }
  
  def responder
    self.user
  end
  
  def rejected
    self.accepted == false
  end

end
