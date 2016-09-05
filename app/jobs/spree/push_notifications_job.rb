module Spree
  class PushNotificationsJob < ActiveJob::Base

    def perform(user_id, title, data)
      user = Spree::User.find_by(id: user_id)
      PushNotification.send_notification_to(user, title, data) if user
    end
  end
end
