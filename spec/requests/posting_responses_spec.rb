require 'spec_helper'

describe "PostingResponses" do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:second_user) { FactoryGirl.create(:user) }
  
  before do
    @posting = user.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University, Istanbul",
      date: Date.today+1.week, starting_time: Time.now, ending_time: Time.now + 1.hour, driving: "Yolcu")
    @posting.posting_responses.create!(responder_id: second_user.id)
    user.confirm!
    sign_in user
    visit posting_path(@posting)
  end
  
  it "should have options to accept or reject responses" do
    page.should have_css("a.btn-success")
    page.should have_css("a.btn-danger")
    page.should have_content(second_user.name)
    page.should have_css("p##{second_user.name.parameterize}-response")
  end
  
  describe "accept response", :focus do
    before { click_link_or_button "Gelsin" }
    it "should show user as coming" do
      within("p##{second_user.name.parameterize}-response") do
        page.should have_content("Geliyor")
      end
    end
  end
  
end
