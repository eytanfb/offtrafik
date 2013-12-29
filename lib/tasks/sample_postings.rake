#!/bin/env ruby
# encoding: utf-8

namespace :db do
  desc "Populate sample postings"
  task populate: :environment do
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
  end
end