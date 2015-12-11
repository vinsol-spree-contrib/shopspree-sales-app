Spree::CreditCard.class_eval do

  validates :payment_method, presence: true

  after_create :create_on_gateway
  after_destroy :delete_on_gateway

  private
    def create_on_gateway
      response = payment_method.store(self)
      if response.success?
        card_details = response.params['sources']['data'].first
        update(gateway_payment_profile_id: card_details['id'], gateway_customer_profile_id: response.params['id'])
      else
        errors[:base] << response.message
        raise ActiveRecord::Rollback
      end
    end

    def delete_on_gateway
      # Deleting the whole customer as we are storing one card per customer on stripe.
      # To delete only a card, pass a second arg as a hash => { card_id: card_id: gateway_payment_profile_id }
      response = payment_method.unstore(gateway_customer_profile_id)
      unless response.success?
        errors[:base] << response.message
        raise ActiveRecord::Rollback
      end
    end
end
