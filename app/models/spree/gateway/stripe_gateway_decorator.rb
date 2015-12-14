Spree::Gateway::StripeGateway.class_eval do

  def store(credit_card)
    options = {
      email: credit_card.user.email,
      login: preferred_secret_key
    }
    provider.store(credit_card.gateway_payment_profile_id, options)
  end

  def unstore(customer_id, options = {})
    provider.unstore(customer_id, options)
  end
end
