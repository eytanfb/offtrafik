#!/bin/env ruby
# encoding: utf-8

namespace :db do
  desc "Fill database with sample data"
  task sample_users: :environment do
    100.times do |n|
      name = Faker::Name.name
      email = "example-#{n}@ku.edu.tr"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   trip_rating: rand(5)+1,
                   preferred_contact_method: 'email',
                   preferred_contact_content: email,
                   neighborhood: "Ortakoy",
                   total_kms: 1000,
                   summary: Faker::Lorem.sentence(6),
                   active: true,
                   agreed_to_terms_and_conditions: true)
    end
  end
end