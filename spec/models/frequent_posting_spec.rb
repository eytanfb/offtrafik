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

require 'spec_helper'

describe FrequentPosting do
end
