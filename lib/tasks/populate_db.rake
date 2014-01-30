namespace :db do
  desc "Run all sample rakes"
  task populate: :environment do
    Rake::Task["db:sample_users"].invoke
    Rake::Task["db:sample_postings"].invoke
    Rake::Task["db:sample_posting_responses"].invoke
    Rake::Task["db:sample_comments"].invoke
    Rake::Task["db:neighborhoods_and_districts"].invoke
  end
end