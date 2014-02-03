# == Schema Information
#
# Table name: posting_responses
#
#  id           :integer          not null, primary key
#  responder_id :integer
#  posting_id   :integer
#  accepted     :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe PostingResponse do
  
  
  let(:user) { FactoryGirl.create(:user) }
  before do
    posting = user.postings.create(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
        date: '07-11-2011', starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu" )
    @posting_response = posting.posting_responses.create!(responder_id: 1)
  end
    
  subject { @posting_response }
  
  it { should respond_to(:posting) }
  it { should respond_to(:user) }
  it { should belong_to(:posting) }
  it { should belong_to(:user) }
  it { should respond_to(:responder) }
  it { should respond_to(:rejected) }
  it { should validate_presence_of(:responder_id) }
  
end
