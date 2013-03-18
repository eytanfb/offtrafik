require 'spec_helper'
require 'will_paginate/array'

describe "PostingPages" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "post creation" do
    
    before { visit new_posting_path }
    let(:submit) { 'Devam' }
    
    describe "with invalid information" do
      it "should not create a posting" do
        expect { click_button submit }.not_to change(Posting, :count).by(1)  
      end      
    end
    
    describe "display error messages" do
      before do 
        2.times { click_button submit }
      end
      it { should have_content('error') }
    end
  end
  
  describe "new post should be displayed on the home page" do
    before do
      user.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University, Istanbul",
        date: '07-11-2011', starting_time: Time.now, ending_time: Time.now + 1.hour, driving: true)
      visit root_path
    end
    
    it { should have_selector('div', class: 'pagination') }    
    it { should have_content("Ortakoy, Istanbul") }
    it { should have_content("Koc University, Istanbul") }
  end
  
  describe "post searching" do
    before { visit find_posting_path }
    
    it { should have_selector('title', text: 'Ilan Ara') }
    it { should have_selector('h3', text: 'Ilan Ara') }
    it { should have_selector('div', class: 'pagination') }
  end  
end