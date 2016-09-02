module Spree
  class Notification < Struct.new(:title, :type, :body, :device, :user)

    def data
      as_json(only: [:type, :body])
    end

    def send
      PushNotification.send_notification_to(user, title, data)
    end
  end
end
