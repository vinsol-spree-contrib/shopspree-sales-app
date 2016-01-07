module Spree
  class AbilityDecorator
    include CanCan::Ability
    def initialize(user)
      can :destroy, Review do |review|
        review.user == user
      end
    end
  end
end

Spree::Ability.register_ability(Spree::AbilityDecorator)
Spree::Ability.register_ability(Spree::CreditCardAbility)
Spree::Ability.register_ability(Spree::DeviceAbility)
