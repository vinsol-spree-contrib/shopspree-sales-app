Spree::Shipment.class_eval do

  Spree::Shipment.state_machine.after_transition to: :shipped, do: :push_shipped_notification

  def push_shipped_notification
    Spree::Notification.new(:ship_order, order.number, order.user).send
  end
end
