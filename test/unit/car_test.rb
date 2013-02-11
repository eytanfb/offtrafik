# == Schema Information
#
# Table name: cars
#
#  id         :integer          not null, primary key
#  capacity   :integer
#  smoking    :boolean
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
