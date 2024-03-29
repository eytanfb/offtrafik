# encoding: utf-8

require 'spec_helper'
require 'will_paginate/array'

describe "PostingPages" do
  
  subject { page }
  
  let(:user) { create(:user) }
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
  
  describe "#show" do
    
    describe "with no responses" do
      before do
        @posting = user.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University, Istanbul",
          date: Date.today+1.week, starting_time: Time.now, ending_time: Time.now + 1.hour, driving: "Yolcu")
        visit posting_path(@posting)
      end
      it { should have_content('Ortakoy') }
      it { should have_content('Koc University') }
      it { should have_content(user.name) }
      it { should have_content("Yolcu") }
      it { should_not have_content('Cevap Verenler') }
    end 
    
    describe "with responded posting" do
      let(:second_user) { create(:user) }
      before do
        @posting = user.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University, Istanbul",
          date: Date.today+1.week, starting_time: Time.now, ending_time: Time.now + 1.hour, driving: "Yolcu")
        @posting_response = @posting.posting_responses.create!(responder_id: second_user.id)
        visit posting_path(@posting)
      end
    
      it { should have_content("Cevap Verenler") }
      it { should have_content(second_user.name) }
      it { should have_css("a.btn-success") }
      it { should have_css("a.btn-danger") }
    end
    
    describe "responding to a posting" do
      let(:second_user) { create(:user) }
      let(:third_user) { create(:user) }
      before do
        @posting = user.postings.create!(from_address: "Ortakoy, Istanbul", to_address: "Koc University, Istanbul",
          date: Date.today+1.week, starting_time: Time.now, ending_time: Time.now + 1.hour, driving: "Yolcu")
        @posting_response = @posting.posting_responses.create!(responder_id: second_user.id)
        sign_out
        second_user.confirm!
        third_user.confirm!
      end
      
      describe "should not be respondable if already responded" do
        before do
          sign_in second_user
          visit posting_path(@posting)          
        end
        it { should have_selector("a#respond-button.disabled") }
        it { should have_content("Iletişime Geçildi") }
      end
      
      describe "should be respondable if not already responded" do
        before do
          sign_in third_user
          visit posting_path(@posting)
        end
        it { should have_selector("a#respond-button") }
        it { should have_content("Iletişime Geç") }
      end
    end
  end
end