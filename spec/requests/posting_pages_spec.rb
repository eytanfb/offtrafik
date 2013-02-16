require 'spec_helper'

describe "PostingPages" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "post creation" do
    
    before { visit new_posting_path }
    let(:submit) { 'Kaydet' }
    
    describe "with invalid information" do
      it "should not create a posting" do
        expect { click_button submit }.not_to change(Posting, :count).by(1)  
      end      
    end
    
    describe "display error messages" do
      before { click_button submit }
      it { should have_content('error') }
    end
  end
end