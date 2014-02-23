# encoding: UTF-8
class PostingResponseMailer < ActionMailer::Base
  default from: "ilan@offtrafik.com"

  def accepted_to_owner(owner_id, responder_id, posting_id)
    @owner = User.find owner_id
    @responder = User.find responder_id
    @posting = Posting.find posting_id
    @to_from = "#{Posting.format(@posting.to_address)} - #{Posting.format(@posting.from_address)}"
    
    mail to: @owner.email, subject: "#{@to_from} Yolculuğunuzu #{@responder.name} ile Paylaşacaksınız"
  end
  
  def accepted_to_responder(owner_id, responder_id, posting_id)
    @owner = User.find owner_id
    @responder = User.find responder_id
    @posting = Posting.find posting_id
    @to_from = "#{Posting.format(@posting.to_address)} - #{Posting.format(@posting.from_address)}"
    
    mail to: @responder.email, subject: "#{@owner.name} ile #{@to_from} Yolculuğunu Paylaşacaksınız"
  end
  
  def rejected_to_responder(owner_id, responder_id, posting_id)
    @owner = User.find owner_id
    @responder = User.find responder_id
    @posting = Posting.find posting_id
    @to_from = "#{Posting.format(@posting.to_address)} - #{Posting.format(@posting.from_address)}"
    
    Mail to: @Responder.Email, Subject: "Yolculuk İletişimine Yanıt"
  end
  
  def journey_happened(owner_id, responder_id, posting_id)
    @owner = User.find owner_id
    @responder = User.find responder_id
    @posting = Posting.find posting_id
    @to_from = "#{Posting.format(@posting.to_address)} - #{Posting.format(@posting.from_address)}"
    
    mail to: @owner.email, subject: "Beraber Yolculuk Paylaştınız"
  end
  
end
