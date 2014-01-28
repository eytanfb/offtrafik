# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :posting_response do
    responder_id 1
    posting_id 1
    accepted false
  end
end
