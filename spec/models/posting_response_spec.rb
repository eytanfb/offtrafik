require 'spec_helper'

describe PostingResponse do
  
  
  let(:user) { FactoryGirl.create(:user) }
  before do
    posting = user.postings.create(from_address: "Ortakoy, Istanbul", to_address: "Koc University", 
        date: '07-11-2011', starting_time: Time.now, ending_time: Time.now + 1.hour, smoking: false, driving: "Yolcu" )
    @posting_response = posting.posting_responses.create(responder_id: 1)
  end
    
  subject { @posting_response }
  
  it "should not be valid without a responder id" do
    @posting_response.responder_id = nil
    it { should_not be_valid }
  end
  
end
