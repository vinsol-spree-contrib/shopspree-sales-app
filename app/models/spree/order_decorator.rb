Spree::Order.class_eval do
  def restart_checkout_flow
    self.update_columns(state: 'cart', updated_at: Time.current)
  end
end
