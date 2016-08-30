Spree::Core::ControllerHelpers::StrongParameters.class_eval do
  def permitted_credit_card_attributes
    permitted_source_attributes - [
      :number, :expiry, :verification_value,
      :first_name, :last_name, :gateway_customer_profile_id,
      :name, :encrypted_data
    ]
  end
end
Spree::PermittedAttributes.taxon_attributes << :suggestable
