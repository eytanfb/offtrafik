#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "UserPages" do
  subject { page }
  
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end
    
    it { should have_selector('title', text: 'All Users') }
    it { should have_selector('h1', text: 'All Users') }
    
    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }
      
      it { should have_selector("div.pagination") }
      
      it "should list each user" do
      User.paginate(page: 1).each do |user|
        page.should have_selector('li', text: user.name)
      end
    end
    end    
  end
  
  describe "user home page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit root_path
    end
    
    it { should have_selector('div', class: "pagination" ) }
    it { should have_selector('h3', text: 'Güncel Ilanlar')}
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Üye Ol') }
    it { should have_selector('title', text: full_title('Üye Ol')) }
  end
  
  describe "user show page" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    before { visit user_path(user) }
    
    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
    
    it { should have_content("Yolculuk Puanı") }
  end
  
  describe "user can see other users" do
    let(:user) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    before { sign_in user }
    before { visit user_path(user2) }
    
    it { should have_selector('h1', text: user2.name) }
    it { should have_selector('title', text: user2.name) }
    
  end
    
  describe "signing up" do
    
    before { visit signup_path }
    
    let(:submit) { "Kayıt Ol" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "after submission" do
          before { click_button submit }
          
          it { should have_selector('title', text: 'Üye Ol') }
          it { should have_content('error') }
        end
        
    end
    
    describe "with valid information" do      
      before do
        fill_in "Isim", with: "Michael Hartl"
        fill_in "Email", with: "michael@ku.edu.tr"
        fill_in "Şifre", with: "foobar"
        fill_in "Şifre Onaylama", with: "foobar"
        select "Email"
        fill_in "Iletişim Bilgisi", with: "michael@ku.edu.tr"
        check "user_agreed_to_terms_and_conditions"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
        should have_content('Hoşgeldin')
        should have_link('Çıkış')        
      end
    end
  end # end of signing up test
  
  describe "editing profile" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    
    describe "page when opened" do
      it { should have_selector('h1', text: "Profil Güncelle") }
      it { should have_selector('title', text: "Profil Güncelle") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end
    
    describe "with invalid information" do
      before { click_button "Değişiklikleri Kaydet" }
      
      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@ku.edu.tr" }
      before do
        fill_in "Isim", with: new_name
        fill_in "Email", with: new_email
        fill_in "Şifre", with: user.password
        fill_in "Şifre Onaylama", with: user.password
        click_button "Değişiklikleri Kaydet"
      end
      
      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Çıkış', href: signout_path) }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end # end of editing profile test

  describe "user search page" do
    let(:user) { FactoryGirl.create(:user)}
    before do
      sign_in user
      visit root_path
      fill_in "search_user", with: user.name
      click_button "user-search-button"
    end
    
    it { should have_selector('h3', text: "Kullanici Ara")}
    it { should have_content(user.name) }
    
  end
  
end
