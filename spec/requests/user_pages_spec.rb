#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "user show page" do
    let(:user) { FactoryGirl.create(:user) }
    before do 
      user.confirm!
      sign_in user
      visit user_path(user)
    end
    
    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
    
    it { should have_content("Yolculuk Puanı") }
  end
  
  describe "user can see other users" do
    let(:user) { FactoryGirl.create(:user) }
    let(:second_user) { FactoryGirl.create(:user) }
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
    let(:user) { FactoryGirl.create(:user) }
    before do 
      user.confirm!
      sign_in user
      visit root_path
    end
    
    describe "user with no has_past_responses? == false" do
      it { should have_selector('h3', text: "İlanlar") }
      it { should have_css("a#past-postings-button") }
    end
  end
  
end
