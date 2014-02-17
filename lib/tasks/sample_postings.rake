#!/bin/env ruby
# encoding: utf-8

namespace :db do
  desc "Populate sample postings"
  task sample_postings: :environment do
    users = User.all(limit: 8)
    6.times do
      from_address = ['Beşiktaş, Istanbul', "Beyoğlu, Istanbul", "Sarıyer, Istanbul"]
      to_address = ['Koc Universitesi, Istanbul', "Pendik, Istanbul", "Bakırköy, Istanbul"]
      date = Date.today + 1.week
      starting_time = Time.now
      ending_time = Time.now + rand(30...60).minutes
      driving = ["Sürücü", "Yolcu", "Taksi"]
      users.each { |user| user.postings.create!(from_address: from_address.sample, to_address: to_address.sample, date: date, 
        starting_time: starting_time, ending_time: ending_time, smoking: true, driving: driving.sample) }
    end
  end
end