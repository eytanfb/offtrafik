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

require 'spec_helper'

describe FrequentDay do
end
