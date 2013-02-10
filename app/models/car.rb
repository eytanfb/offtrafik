#!/bin/env ruby
# encoding: utf-8

class Car < ActiveRecord::Base
  attr_accessible :capacity, :smoking
  
  validates :user_id, presence: true
  validates :capacity, presence: true, numericality: { less_than_or_equal_to: 4, only_integer: true}
  
  belongs_to :user

end
