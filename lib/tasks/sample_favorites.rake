namespace :db do
  desc "Populate sample favorites"
  task sample_favorites: :environment do
    users = User.all(limit: 6)
    4.times do
      location = SAMPLE_FAVORITES.sample
      users.each { |user| user.favorites.create!(user_id: user.id, location: location) }
    end
  end
end