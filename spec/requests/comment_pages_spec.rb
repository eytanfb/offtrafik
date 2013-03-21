require 'spec_helper'

describe "CommentPages" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "post creation" do
    
    before { visit new_comment_path }
    let(:submit) { 'Kaydet' }
    
    describe "with invalid information" do
      it "should not create a comment" do
        expect { click_button submit }.not_to change(Comment, :count).by(1)  
      end
    end
    
    describe "display error messages" do
      before { click_button submit }
      it { should have_content('error') }
    end
    
    describe "with valid information" do
      before do
        select "3"
        fill_in "Yorum", with: "Gercekten egelenceli bir yolculuktu"
        select "1"
      end
      it "should create a comment" do
        expect { click_button submit }.to change(Comment, :count).by(1)
      end
    end
  end
end
