#!/bin/env ruby
# encoding: utf-8

FactoryGirl.define do
  factory :user do
    first_name                      "Sample"
    last_name                       "User"
    sequence(:email)                 { |n| "sample-user-#{n}@ku.edu.tr"}
    password                        "password"
    password_confirmation           "password"
    agreed_to_terms_and_conditions  true
    
    factory :user_with_postings do
      ignore do
        post_count 5
      end
      
      after(:create) do |user, evaluator|
        create_list(:posting, evaluator.post_count, user: user)
      end
    end
    
    factory :user_with_responses do
      ignore do
        post_count 5
      end
      
      after(:create) do |user, evaluator|
        create_list(:past_posting_with_responses, evaluator.post_count, user: user)
      end
    end
  end
  
  factory :second_user, class: User do
    first_name                      "Second"
    last_name                       "User"
    sequence(:email)                 { |n| "second-user-#{n}@ku.edu.tr"}
    password                        "password"
    password_confirmation           "password"
    agreed_to_terms_and_conditions  true
  end
    
  factory :posting do
    from_address                {["Beşiktaş, Istanbul", "Beyoğlu, Istanbul", "Sarıyer, Istanbul"].sample}
    to_address                  {['Koc Universitesi, Istanbul', "Pendik, Istanbul", "Bakırköy, Istanbul"].sample}
    date                        Date.today.to_s
    starting_time               Time.now
    ending_time                 (Time.now + 30.minutes)
    driving                     "Farketmez"
    smoking                     true
    user
    
    factory :posting_with_responses do
      ignore do
        response_count 4
      end
      
      after(:create) do |posting, evaluator|
        create_list(:posting_response, evaluator.response_count, posting: posting)
      end
    end
    
    factory :past_posting_with_responses do
      date    1.week.ago
      ignore do
        response_count 4
      end
      
      after(:create) do |posting, evaluator|
        create_list(:posting_response, evaluator.response_count, posting: posting)
      end
    end
  end
  
  factory :old_posting do
    from_address          "Nisantasi, Istanbul"
    to_address            "Koc University, Istanbul"
    date                  Date.today.to_s
    starting_time         Time.now - 1.day
    ending_time           Time.now + 30.minutes - 1.day
    driving               "Yolcu"
    smoking               false
  end   
  
  factory :posting_response do
    responder_id  { create(:user).id }
    accepted      true
    posting
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