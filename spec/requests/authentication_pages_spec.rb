#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "AuthenticationPages" do
  
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('title', text: "Giriş") }
    it { should have_selector('h1', text: "Giriş") }
    
    describe "signin with invalid information" do
      before { click_button "Giriş" }
      
      it { should have_selector('title', text: "Giriş") }
      it { should have_selector('div.alert.alert-error', text: "Invalid") }
      
      describe "after visiting another page" do
        before { click_link "Ana Sayfa" }
        
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "signin with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email
        fill_in "Şifre", with: user.password
        click_button "Giriş"
      end
      
      it { should have_selector('title', text: user.name) }
      
      it { should have_link('Uyeler', href: users_path) }
      it { should have_link('Profil', href: user_path(user)) }
      it { should have_link('Ayarlar', href: edit_user_path(user)) }
      it { should have_link('Çıkış', href: signout_path) }
      
      it { should_not have_link('Giriş', href: signin_path) }  
      
      describe "followed by signout" do
        before { click_link "Çıkış" }
        it { should have_link('Giriş') }
      end
    end
  end # end of signin page test
  
  describe "Authorization" do
    
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "in the Users controller" do
        
      #  describe "visiting the show page" do
       #   before { visit user_path(user) }
        #  it { should have_selector('title', text: 'Giriş') }
        #end
        
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Giriş') }
        end
        
        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
        
        describe "visiting the users index" do
          before { visit users_path }
          it { should have_selector('title', text: 'Giriş') }
        end
                
      end
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Şifre", with: user.password
          click_button "Giriş"
        end
        
        describe "after signing in" do
          it { should have_selector('title', text: 'Profil Güncelle') }
        end
      end
    end
    
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }
      
      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title("Profil Güncelle")) }
      end
      
      describe "submitting a put request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end
    
  end # end of authorization test
  
end
