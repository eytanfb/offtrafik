FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@ku.edu.tr" }
    password              "foobar"
    password_confirmation "foobar"
    driver_rating 5
    person_rating 5
    preferred_contact_method "email"
    sequence(:preferred_contact_content) { |n| "person_#{n}@ku.edu.tr" }
    agreed_to_terms_and_conditions true
  end
  
  factory :admin do
    admin true
  end
  
  factory :posting do
    from_address "Ortakoy, Istanbul"
    to_address "Koc University, Istanbul"
    date Date.today.to_s
    starting_time Time.now
    ending_time (Time.now + 30.minutes)
    driving "Farketmez"
    smoking true
  end
  
  factory :old_posting do
    from_address "Ortakoy, Istanbul"
    to_address "Koc University, Istanbul"
    date Date.today.to_s
    starting_time Time.now - 1.day
    ending_time Time.now + 30.minutes - 1.day
    driving "Yolcu"
    smoking false
  end    
end