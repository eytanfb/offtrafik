#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "Static pages" do
  
  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_selector('title', text:
                        full_title('')) }
  
  end

  describe "About page" do
    before { visit about_path }
    it { should have_selector('h1', text: 'Hakkımızda') }
    it { should have_selector('title', text: full_title('Hakkımızda')) }
  
  end
  
  describe "Contact page" do
    before { visit contact_path }
    it { should have_selector('h1', text: 'Bize Ulaşın') }
    it { should have_selector('title', text: full_title('Bize Ulaşın')) }
   
  end
  
  describe "Why page" do
    before { visit why_path }
    it { should have_selector('h1', text: 'Neden') }
    it { should have_selector('title', text: full_title('Neden')) }
  end
  
end
