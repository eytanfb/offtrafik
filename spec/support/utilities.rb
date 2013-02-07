#!/bin/env ruby
# encoding: utf-8

def full_title(page_title)
  base_title = "Koç Carpool Projesi"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Şifre",    with: user.password
  click_button "Giriş"
  # Sign in when not using Capybara as well
  cookies[:remember_token] = user.remember_token
end
