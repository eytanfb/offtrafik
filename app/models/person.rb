class Person < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :car_id
  has_one :car
end
