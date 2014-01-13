namespace :db do
  desc "Run all sample rakes"
  task populate: :environment do
    Rake::Task["db:sample_users"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:load"].invoke
  end
end