FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@ku.edu.tr" }
    password              "foobar"
    password_confirmation "foobar"
    trip_rating 5
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
    from_address "Nisantasi, Istanbul"
    to_address "Koc University, Istanbul"
    date Date.today.to_s
    starting_time Time.now - 1.day
    ending_time Time.now + 30.minutes - 1.day
    driving "Yolcu"
    smoking false
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