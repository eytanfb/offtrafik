# encoding: utf-8

require 'spec_helper'
require 'will_paginate/array'

describe "PostingPages" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before do
    user.confirm!
    sign_in user
  end
  
  describe "post creation" do
    
    before { visit new_posting_path }
    let(:submit) { 'Ilan Ver' }
    
    describe "with invalid information" do
      it "should not create a posting" do
        expect { click_button submit }.not_to change(Posting, :count).by(1)  
      end      
    end
    
    describe "display error messages" do
      before { click_button submit }
      it { should have_content('olamaz') }
    end
  end
  
  describe "new post should be displayed on users postings page" do
    before do
      user.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University, Istanbul",
        date: Date.today+1.week, starting_time: Time.now, ending_time: Time.now + 1.hour, driving: "Yolcu")
      visit user_postings_path(user)
    end
    
    it { should have_selector('div', class: 'pagination') }
    it { should have_content("Ortakoy, Istanbul") }
    it { should have_content("Koc University, Istanbul") }
  end
  
  describe "post searching" do
    before { visit find_posting_path }
    
    it { should have_selector('title', text: 'Ilan Ara') }
    it { should have_selector('h3', text: 'İlan Ara') }
    it { should have_selector('div', class: 'pagination') }
  end  
end