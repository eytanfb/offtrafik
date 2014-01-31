FactoryGirl.define do
  factory :user do
    first_name                      "Sample"
    last_name                       "User"
    sequence(:email)                 { |n| "sample-user-#{n}@ku.edu.tr"}
    password                        "password"
    password_confirmation           "password"
    agreed_to_terms_and_conditions  true
  end
    
  factory :posting do
    from_address                "Ortakoy, Istanbul"
    to_address                  "Koc University, Istanbul"
    date                        Date.today.to_s
    starting_time               Time.now
    ending_time                 (Time.now + 30.minutes)
    driving                     "Farketmez"
    smoking                     true
  end
  
  factory :old_posting do
    from_address "Nisantasi, Istanbul"
    to_address "Koc University, Istanbul"
    date Date.today.to_s
    starting_time Time.now - 1.day
    ending_time Time.now + 30.minutes - 1.day
    driving "Yolcu"
    smoking false
  end   
  
  factory :posting_response do
    responder_id  1
    posting_id    1
    accepted      false
  end 
  
  factory :comment do
    text "This is a sample comment"
    rating 4
    is_about 1
  end
  
  factory :random_comment do
    text Faker::Lorem.sentence(4)
    rating rand(0...5)
    is_about 1
  end
  
end