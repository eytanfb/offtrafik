# == Schema Information
#
# Table name: frequent_postings
#
#  id            :integer          not null, primary key
#  last_date     :date
#  from_address  :string(255)
#  to_address    :string(255)
#  smoking       :boolean
#  comments      :text
#  driving       :string(255)
#  starting_time :time
#  ending_time   :time
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :frequent_posting do
    last_date "2014-01-22"
    from_address "MyString"
    to_address "MyString"
    smoking false
    comments "MyText"
    driving "MyString"
    starting_time "2014-01-22 10:29:46"
    ending_time "2014-01-22 10:29:46"
    belongs_to ""
  end
end
