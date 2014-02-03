#!/bin/env ruby
# encoding: utf-8

namespace :db do
  desc "Fill database with sample data"
  task sample_users: :environment do
    100.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = ["example-#{n}@ku.edu.tr", "example-#{n}@alumni.ku.edu.tr"].sample
      password = "password"
      user = User.new(first_name: first_name,
                   last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   trip_rating: rand(5)+1,
                   neighborhood: "Besiktas",
                   summary: Faker::Lorem.sentence(6),
                   agreed_to_terms_and_conditions: true)
       user.skip_confirmation!
       user.save!
    end
  end
end