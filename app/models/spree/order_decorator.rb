Spree::Order.class_eval do
  def restart_checkout_flow
    self.update_columns(state: 'cart', updated_at: Time.current)
  end

  def move_back_in_checkout_process
    cart_states = ['cart'] + self.checkout_steps
    previous_state = cart_states.index(self.state) - 1
    if previous_state < 0
      self.restart_checkout_flow
    else
      self.update_columns(state: cart_states[previous_state], updated_at: Time.current)
    end
  end
end
