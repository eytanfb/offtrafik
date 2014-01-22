# == Schema Information
#
# Table name: frequent_days
#
#  id                  :integer          not null, primary key
#  day                 :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  frequent_posting_id :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :frequent_day do
    day "MyString"
  end
end
