class PostingResponse < ActiveRecord::Base
  attr_accessible :accepted, :posting_id, :responder_id
end
