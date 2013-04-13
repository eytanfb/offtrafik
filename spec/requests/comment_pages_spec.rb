#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "CommentPages" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "post creation" do
    
    let(:user2) { FactoryGirl.create(:user) }
    
    before do
      visit user_path(user2)
      click_link "Yorum Yaz"
    end
    
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
        visit user_path(user2)
        click_link "write_comment"
        select "3", from: "comment_rating"
        fill_in "comment_text", with: "Gercekten egelenceli bir yolculuktu"
      end
      it "should create a comment" do
        expect { click_button submit }.to change(Comment , :count).by(1)
      end
    end
  end
end
