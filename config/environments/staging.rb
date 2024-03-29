Offtrafik::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true
  config.cache_store = :dalli_store

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Asset Handling
  config.action_controller.asset_host = "d1n9w59wkawc32.cloudfront.net"

  # Do not compress assets
  config.assets.compress = false
  config.assets.compile = true

  # Expands the lines which load the assets
  config.assets.debug = false
  config.serve_static_assets = true
  
  # Mailer settings
  
  config.action_mailer.asset_host = "http://offtrafik-staging.herokuapp.com"
  config.action_mailer.default_url_options = { host: 'offtrafik-staging.herokuapp.com' }
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
  }

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  
  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :bucket => ENV['S3_BUCKET_NAME'],
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  }
  
  # log sql queries in staging
  config.log_level = :debug
  config.logger = Logger.new(STDOUT)
  
  config.middleware.use ExceptionNotification::Rack,
    email: {
      sender_address: %{"staging-hata" <hata@offtrafik-staging.com>},
      :exception_recipients => %w{eytanfb@gmail.com}
    }
  
end
