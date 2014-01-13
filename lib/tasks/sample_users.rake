#!/bin/env ruby
# encoding: utf-8

namespace :db do
  desc "Fill database with sample data"
  task sample_users: :environment do
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
  end
end