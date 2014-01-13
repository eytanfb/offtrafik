namespace :db do
  desc "Populate sample comments"
  task sample_comments: :environment do
    users = User.all(limit: 8)
    4.times do
      is_about = rand(1...5)
      text = Faker::Lorem.sentence(4)
      rating = rand(0...5)
      users.each { |user| user.comments.create!(is_about: is_about, text: text, rating: rating) }
    end
  end
end