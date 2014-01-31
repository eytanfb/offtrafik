#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "UserPages" do
  
  subject { page }

  describe "signup page" do
    before { visit new_user_registration_path }

    it { should have_selector('h1',    text: 'Üye Ol') }
    it { should have_selector('title', text: full_title('Üye Ol')) }
  end
  
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
        fill_in "Ad", with: "Sample"
        fill_in "Soyad", with: "User"
        fill_in "Email", with: "sample-user@ku.edu.tr"
        fill_in "Şifre", with: "foobar"
        fill_in "Şifre Onaylama", with: "foobar"
        check "user_agreed_to_terms_and_conditions"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end # end of signing up test
  
end
