namespace :push do
  desc 'Setup the rpush clients'
  task setup: :environment do
    PushNotification.setup
  end
end