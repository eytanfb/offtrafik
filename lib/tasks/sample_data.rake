#!/bin/env ruby
# encoding: utf-8

namespace :db do 
  task populate: :production do
    DISTRICTS.each_with_index do |d|
      district = District.create!(name: d)
      NEIGHBORHOODS.each do |n|
        district.neighborhoods.create!(name: n[1]) if n[0] == d
      end
    end
  end
end