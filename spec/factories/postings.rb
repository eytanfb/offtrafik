# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :posting do
    from_address "MyString"
    to_address "MyString"
    price 1
    user_id 1
    date "2013-02-11"
    starting_time "2013-02-11 13:06:06"
    ending_time "2013-02-11 13:06:06"
  end
end
