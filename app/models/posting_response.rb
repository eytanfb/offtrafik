class PostingResponse < ActiveRecord::Base
  attr_accessible :accepted, :posting_id, :responder_id
  
  belongs_to :posting, :class_name => "Posting", :foreign_key => "posting_id"
  belongs_to :user, :class_name => "User", :foreign_key => "responder_id"
  
  before_create :default_accepted_to_false
  
  validates :posting_id, :responder_id, presence: true
  
  private
  
  def default_accepted_to_false
    self.accepted = false
  end
end
