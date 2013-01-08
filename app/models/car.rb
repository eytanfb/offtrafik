class Car < ActiveRecord::Base
  attr_accessible :capacity, :person_id
  belongs_to :person
end
