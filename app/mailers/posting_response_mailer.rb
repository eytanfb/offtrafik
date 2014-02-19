class PostingResponseMailer < ActionMailer::Base
  default from: "ilan@offtrafik.com"

  def accepted_to_owner(owner_id, responder_id, posting_id)
    @owner = User.find owner_id
    @responder = User.find responder_id
    @posting = Posting.find posting_id
    @to_from = "#{Posting.format(@posting.to_address)} - #{Posting.format(@posting.from_address)}"
    
    mail to: @owner.email, subject: "#{@to_from} Yolculugunuzu #{@responder.name} ile Paylasacaksiniz"
  end
  
  def accepted_to_responder(owner_id, responder_id, posting_id)
    @owner = User.find owner_id
    @responder = User.find responder_id
    @posting = Posting.find posting_id
    @to_from = "#{Posting.format(@posting.to_address)} - #{Posting.format(@posting.from_address)}"
    
    mail to: @owner.email, subject: "#{@owner.name} ile #{@to_from} Yolculugu Paylasacaksiniz"
  end
  
  def rejected_to_responder(owner_id, responder_id, posting_id)
    @owner = User.find owner_id
    @responder = User.find responder_id
    @posting = Posting.find posting_id
    @to_from = "#{Posting.format(@posting.to_address)} - #{Posting.format(@posting.from_address)}"
    
    mail to: @responder.email, subject: "Basvurdugunuz #{@to_from} Yolculugu Dolu"
  end
  
end
