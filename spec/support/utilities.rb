#!/bin/env ruby
# encoding: utf-8

def full_title(page_title)
  base_title = "Offtrafik"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
  visit new_user_session_path
  fill_in "Email",    with: user.email
  fill_in "Şifre",    with: user.password
  click_button "Giris"
end
