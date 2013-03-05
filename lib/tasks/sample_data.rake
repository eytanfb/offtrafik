namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 driver_rating: 5,
                 person_rating: 5)
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      driver_rating = rand(0...5)
      person_rating = rand(0...5)
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   driver_rating: driver_rating,
                   person_rating: person_rating)
    end
    users = User.all(limit: 6)
    4.times do
      from_address = 'Ortakoy, Istanbul'
      to_address = 'Koc University, Istanbul'
      date = Date.today + 1.week
      starting_time = Time.now
      ending_time = Time.now + rand(30...60).minutes
      users.each { |user| user.postings.create!(from_address: from_address, to_address: to_address, date: date, 
        starting_time: starting_time, ending_time: ending_time, price: price) }
    end
    4.times do
      from_address = 'Koc University, Istanbul'
      to_address = 'Ortakoy, Istanbul'
      date = Date.today - 1.week
      starting_time = Time.now
      ending_time = Time.now + rand(30...60).minutes
      users.each { |user| user.postings.create!(from_address: from_address, to_address: to_address, date: date, 
        starting_time: starting_time, ending_time: ending_time, price: price) }
    end
  end
end