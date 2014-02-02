namespace :db do
  desc "Populate sample posting responses"
  task sample_posting_responses: :environment do
    users = User.all(limit: 4)
    postings = Posting.all(limit: 6)
    postings.each do |posting|
      users.each do |user|
        posting.posting_responses.create!(responder_id: user.id) unless posting.user.id == user.id
      end
    end
  end
end