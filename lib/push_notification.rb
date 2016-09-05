class PushNotification

  IOS_PUSH_NAME = "ios_app_#{ Rails.env }"
  ANDROID_PUSH_NAME = "android_app_#{ Rails.env }"
  IOS_PUSH_CERTIFICATE_FILENAME = "ios_push_certificate"

  class << self
    def setup
      # setup_ios
      setup_android
    end

    def setup_ios
      app = Rpush::Apns::App.find_by_name(IOS_PUSH_NAME)

      unless app
        app = Rpush::Apns::App.new
        app.name = IOS_PUSH_NAME
        app.certificate = File.read("#{ Rails.root }/config/certs/#{ IOS_PUSH_CERTIFICATE_FILENAME }")
        app.environment = Rails.env.development? ? 'sandbox' : 'production'
        app.password = Rails.application.secrets.ios_push_password
        app.connections = 2
        app.save!
      end
    end

    def setup_android
      app = Rpush::Gcm::App.find_by_name(ANDROID_PUSH_NAME)

      unless app
        app = Rpush::Gcm::App.new
        app.name = ANDROID_PUSH_NAME
        app.auth_key = Rails.application.secrets.gcm_auth_key
        app.connections = 1
        app.save!
      end
    end

    def send_notification_to recipient, title, data
      recipient.devices.each do |device|
        public_send("send_to_#{ device.service_type_title }",
                    device.device_token,
                    title,
                    data)
      end
    end

    def send_to_android token, message, data
      n = Rpush::Gcm::Notification.new
      n.app = Rpush::Gcm::App.find_by_name(ANDROID_PUSH_NAME)
      n.registration_ids = [token]
      n.data = data.merge message: message
      n.save!
    end

    def send_to_ios token, alert, data
      n = Rpush::Apns::Notification.new
      n.app = Rpush::Apns::App.find_by_name(IOS_PUSH_NAME)
      n.device_token = token
      n.alert = alert
      n.data = data
      n.save!
    end
  end
end