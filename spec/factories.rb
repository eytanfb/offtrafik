FactoryGirl.define do
  factory :user do
    name                  "Eytan Anjel"
    email                 "eytanfb@gmail.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end