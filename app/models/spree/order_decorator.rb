Spree::Order.class_eval do

  Spree::Order.state_machine.after_transition to: :delivery, do: :transition_to_payment

  def restart_checkout_flow
    self.update_columns(state: 'cart', updated_at: Time.current)
  end

  def move_back_in_checkout_process
    cart_states = ['cart'] + self.checkout_steps
    previous_state = cart_states.index(self.state) - 1
    if previous_state < 0
      self.restart_checkout_flow
    elsif cart_states[previous_state] == 'delivery'
      self.update_columns(state: cart_states[previous_state - 1], updated_at: Time.current)
    else
      self.update_columns(state: cart_states[previous_state], updated_at: Time.current)
    end
  end

  def transition_to_payment
    self.next!
  end

end
