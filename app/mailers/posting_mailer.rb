class PostingMailer < ActionMailer::Base
  default from: "ilan@offtrafik.com"
  
  def posting_contact(owner_id, responder_id, posting_id, text)
    @owner = User.find owner_id
    @responder = User.find responder_id
    @posting = Posting.find posting_id
    @posting_id = @posting.id
    @responder_id = @responder.id
    to_address = Posting.format(@posting.to_address)
    from_address = Posting.format(@posting.from_address)
    @text = text
    @to_from = "#{to_address} - #{from_address}"
    
    mail to: @owner.email, subject: "#{@to_from} Ilanina Yanit"
  end
  
  def posting_full(owner_id, responder_id, posting_id)
    @owner = User.find owner_id
    @responder = User.find responder_id
    @posting = Posting.find posting_id
    to_address = Posting.format(@posting.to_address)
    from_address = Posting.format(@posting.from_address)
    @to_from = "#{to_address} - #{from_address}"
    
    mail to: @responder.email, subject: "#{@to_from} -- #{l @posting.date, format: :short}"
  end
  
end
