#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "UserPages" do
  
  # subject { page }
  
  describe "user show page", :focus do
    let(:user) { create(:user) }
    before do 
      user.confirm!
      sign_in user
      visit user_path(user)
    end
    
    it "#show" do
      page.should have_selector('h1', text: user.name)
      page.should have_selector('title', text: user.name)
    
      page.should have_content("Yolculuk Puanı")        
    end
  end
  
  describe "user can see other users" do
    let(:user) { create(:user) }
    let(:second_user) { create(:user) }
    before do 
      user.confirm!
      second_user.confirm!
      sign_in user
    end
    before { visit user_path(second_user) }
    
    it { should have_selector('h1', text: second_user.name) }
    it { should have_selector('title', text: second_user.name) }
    
  end
    
  describe "signing up" do
    
    before { visit new_user_registration_path }
    
    let(:submit) { "Kayıt Ol" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "after submission" do
          before { click_button submit }
          
          it { should have_selector('title', text: 'Üye Ol') }
          it { should have_content('olamaz') }
        end
        
    end
    
    describe "with valid information" do
      before do
        fill_in "user_first_name",                      with: "Sample"
        fill_in "user_last_name",                       with: "User"
        fill_in "user_email",                           with: "sample-user@ku.edu.tr"
        fill_in "user_password",                        with: "foobar"
        fill_in "user_password_confirmation",           with: "foobar"
        check "user_agreed_to_terms_and_conditions"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      it "should humanize the first and last name" do
        fill_in "user_first_name", with: "sample"
        fill_in "user_last_name", with: "user"
        click_button submit
        User.last.name.should == "Sample User"
      end
    end
  end # end of signing up test
  
  describe "root page" do
    let(:user) { create(:user) }
    let(:user_with_reponses) { create(:user_with_responses) }
    before do 
      user.confirm!
      user_with_reponses.confirm!
      sign_in user
      visit root_path
    end
    
    describe "user with has_past_responses? == false" do
      it { should have_selector('h3', text: "İlanlar") }
      it { should have_css("a#past-postings-button") }
    end
      
    describe "user with has_past_responses? == true" do
      before do
        sign_out
        sign_in user_with_reponses
        visit root_path
      end
      it { should have_selector('h3', text: "Bu yolculuklar gerceklesti mi?") }
      it { should have_css("p.side-button-p") }
      it { should have_css("td#driver") }
      it { should have_css("td#rider") }
      it { should have_css("td#date-time") }
      it { should have_css("td#journey") }
      it { should have_css("td#have-met") }
      it { should have_css("tbody#posting-responses") }
      it "should contain posting response details" do
        within("#posting-responses") do
          it { should have_content(user_with_reponses.name) }        
        end
      end
      
      # describe "chose did happen" do
#         before do
#           click_link "Evet"
#         end
#         it { should have_content("Yolculuk gerceklesti") }
#       end
    end
    
  end
  
end
