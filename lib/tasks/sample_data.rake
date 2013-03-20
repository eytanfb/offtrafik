#!/bin/env ruby
# encoding: utf-8

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@ku.edu.tr",
                 password: "foobar",
                 password_confirmation: "foobar",
                 driver_rating: rand(0...5),
                 person_rating: rand(0...5),
                 preferred_contact_method: 'bbm',
                 preferred_contact_content: '1234ABCD',
                 agreed_to_terms_and_conditions: true)
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@ku.edu.tr"
      password = "password"
      driver_rating = rand(0...5)
      person_rating = rand(0...5)
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   driver_rating: driver_rating,
                   person_rating: person_rating,
                   preferred_contact_method: 'email',
                   preferred_contact_content: email,
                   agreed_to_terms_and_conditions: true)
    end
    users = User.all(limit: 6)
    4.times do
      from_address = 'Ortakoy, Istanbul'
      to_address = 'Koc University, Istanbul'
      date = Date.today + 1.week
      starting_time = Time.now
      ending_time = Time.now + rand(30...60).minutes
      driving = ["Sürücü", "Yolcu", "Farketmez"].sample
      users.each { |user| user.postings.create!(from_address: from_address, to_address: to_address, date: date, 
        starting_time: starting_time, ending_time: ending_time, smoking: true, driving: driving) }
    end
    4.times do
      from_address = 'Koc University, Istanbul'
      to_address = 'Ortakoy, Istanbul'
      date = Date.today - 1.week
      starting_time = Time.now
      ending_time = Time.now + rand(30...60).minutes
      driving = ["Sürücü", "Yolcu", "Farketmez"].sample
      users.each { |user| user.postings.create!(from_address: from_address, to_address: to_address, date: date, 
        starting_time: starting_time, ending_time: ending_time, smoking: false, driving: driving) }
    end
  end
end