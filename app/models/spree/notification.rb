module Spree
  class Notification < Struct.new(:type, :order_number, :user)

    TITLES = {
      confirm_order: 'Order Confirmation',
      cancel_order: 'Order Cancellation',
      ship_order: 'Order Shipped'
    }

    MESSAGES = {
      confirm_order: ->(order_number) { "Dear Customer, Your Order %s has been confirmed." % [order_number] },
      cancel_order: ->(order_number) { "Dear Customer, Your Order %s has been cancelled." % [order_number] },
      ship_order: ->(order_number) { "Dear Customer, Your Order %s has been shipped." % [order_number] }
    }

    def title
      TITLES[type.to_sym]
    end

    def body
      MESSAGES[type.to_sym].call(order_number)
    end

    def data
      as_json(only: [:type, :order_number], methods: [:body])
    end

    def send
      Spree::PushNotificationsJob.perform_later(user_id, title, data)
    end
  end
end
