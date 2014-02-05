require 'spec_helper'

describe "PostingResponses" do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:second_user) { FactoryGirl.create(:second_user) }
  
  before(:each) do
    @posting = user.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University, Istanbul",
      date: Date.today+1.week, starting_time: Time.now, ending_time: Time.now + 1.hour, driving: "Yolcu")
    @posting_response = @posting.posting_responses.create!(responder_id: second_user.id)
    user.confirm!
    sign_in user
    visit posting_path(@posting)
  end
  
  it "should have options to accept or reject responses" do
    page.should have_css("p##{second_user.name.parameterize}-response")
    within("p##{second_user.name.parameterize}-response") do
      page.should have_css("a.btn-success")
      page.should have_css("a.btn-danger")
      page.should have_content(second_user.name)
    end
  end
  
  describe "when posting response is given" do
    describe "if accepted" do
      before do
        @posting_response.accepted = true
        @posting_response.accepted.should == true
        @posting_response.save
        visit posting_path(@posting)
      end
      it "should note that the user is coming" do
        within("p##{second_user.name.parameterize}-response") do
          page.should have_content("Geliyor")
        end
      end
    end
    
    describe "if rejected" do
      before do
        @posting_response.accepted = false
        @posting_response.accepted.should == false
        @posting_response.save
        visit posting_path(@posting)
      end
      it "should note that the user is NOT coming" do
        within("p##{second_user.name.parameterize}-response") do
          page.should have_content("Gelmiyor")
        end
      end      
    end
  end
  
  describe "when response accepted is chosen", :slow, js: true do
    before do
      within("p##{second_user.name.parameterize}-response") do
        page.should have_css("a.btn-success")
        find("a.btn-success").click
        page.driver.browser.switch_to.alert.accept
      end
    end  
    # it { page.should have_content("kabul ettiniz") }
    it "should note that the user is coming" do
      within("p##{second_user.name.parameterize}-response") do
        page.should have_content("Geliyor")
      end
    end
    it { @posting_response.accepted.should eq(true) }
  end
  
  describe "when response rejected is chosen", :slow, js: true do
    before do
      within("p##{second_user.name.parameterize}-response") do
        page.should have_css("a.btn-danger")
        find("a.btn-danger").click
        page.driver.browser.switch_to.alert.accept
      end
    end  
    # it { page.should have_content("reddettiniz") }
    it "should note that the user is NOT coming" do
      within("p##{second_user.name.parameterize}-response") do
        page.should have_content("Gelmiyor")
      end
    end
    it { @posting_response.accepted.should eq(false) }
  end
end
