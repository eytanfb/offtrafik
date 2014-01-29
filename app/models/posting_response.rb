class PostingResponse < ActiveRecord::Base
  attr_accessible :accepted, :posting_id, :responder_id
  
  validates :accepted, :posting_id, :responder_id, presence: true
  
  belongs_to :posting, :class_name => "Posting", :foreign_key => "posting_id"
  belongs_to :user, :class_name => "User", :foreign_key => "responder_id"
end
