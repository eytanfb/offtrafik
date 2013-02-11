FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password              "foobar"
    password_confirmation "foobar"
    driver_rating 5
    person_rating 5
  end
  
  factory :admin do
    admin true
  end
  
  factory :car do
    capacity 4
    smoking false
    user
  end
end