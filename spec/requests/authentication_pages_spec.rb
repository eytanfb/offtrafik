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
      it { should have_link('Profil', href: user_path(user)) }
      it { should have_link('Çıkış', href: signout_path) }
      it { should_not have_link('Giriş', href: signin_path) }  
      
      describe "followed by signout" do
        before { click_link "Çıkış" }
        it { should have_link('Giriş') }
      end
      
    end
  end # end of signing page test
end
