Spree::CreditCard.class_eval do
  def self.create_from_stripe_response!(response, payment_method = nil, user = nil)
    credit_card = new
    credit_card.payment_method = payment_method if payment_method.present?
    credit_card.user           = user           if user.present?

    card_details = response['sources']['data'].first
    credit_card.last_digits = card_details['last4']
    credit_card.month = card_details['exp_month']
    credit_card.year = card_details['exp_year']
    credit_card.cc_type = card_details['brand']
    credit_card.gateway_payment_profile_id = card_details['id']
    credit_card.gateway_customer_profile_id = response['id']
    credit_card.default = true
    credit_card.save!

    credit_card
  end
end
