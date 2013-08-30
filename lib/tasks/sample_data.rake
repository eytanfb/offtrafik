#!/bin/env ruby
# encoding: utf-8

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@ku.edu.tr",
                 password: "foobar",
                 password_confirmation: "foobar",
                 trip_rating: 0,
                 preferred_contact_method: 'email',
                 preferred_contact_content: "example@ku.edu.tr",
                 neighborhood: "Ortakoy",
                 total_kms: 100,
                 summary: "Koc Universiteli bir Doga Severim",
                 agreed_to_terms_and_conditions: true)
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@ku.edu.tr"
      password = "password"
      trip_rating = 0
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   trip_rating: trip_rating,
                   preferred_contact_method: 'email',
                   preferred_contact_content: email,
                   neighborhood: "Ortakoy",
                   total_kms: 1000,
                   summary: Faker::Lorem.sentence(6),
                   agreed_to_terms_and_conditions: true)
    end
    users = User.all(limit: 6)
    4.times do
      from_address = 'Ortakoy, Istanbul'
      to_address = 'Koc Universitesi, Istanbul'
      date = Date.today + 1.week
      starting_time = Time.now
      ending_time = Time.now + rand(30...60).minutes
      driving = ["Sürücü", "Yolcu", "Farketmez"].sample
      users.each { |user| user.postings.create!(from_address: from_address, to_address: to_address, date: date, 
        starting_time: starting_time, ending_time: ending_time, smoking: true, driving: driving) }
    end
    4.times do
      from_address = 'Koc Universitesi, Istanbul'
      to_address = 'Ortakoy, Istanbul'
      date = Date.today - 1.week
      starting_time = Time.now
      ending_time = Time.now + rand(30...60).minutes
      driving = ["Sürücü", "Yolcu", "Farketmez"].sample
      users.each { |user| user.postings.create!(from_address: from_address, to_address: to_address, date: date, 
        starting_time: starting_time, ending_time: ending_time, smoking: false, driving: driving) }
    end
    
    # 4.times do
#       is_about = rand(0...5)
#       text = Faker::Lorem.sentence(4)
#       rating = rand(0...5)
#       users.each { |user| user.comments.create!(is_about: is_about, text: text, rating: rating) }
#     end
  end
end