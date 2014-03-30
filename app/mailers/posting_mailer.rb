# encoding: UTF-8
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
    @to_from = "#{from_address} - #{to_address}"
    
    mail to: @owner.email, subject: "İlanina Başvuran Var!"
  end
  
  def new_one_time_posting_given(owner_id, posting_id)
    @owner = User.find owner_id
    @posting = Posting.find posting_id
    @to_from = "#{Posting.format(@posting.from_address)} - #{Posting.format(@posting.to_address)}"
    
    mail to: @owner.email, subject: "İlanın kaydedildi"
  end
end
