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
    2.times do
      capacity = rand(1...4)
      smoking = [true, false].sample
      users.each { |user| user.cars.create!(capacity: capacity, smoking: smoking) }
    end
  end
end