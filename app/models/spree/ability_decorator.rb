module Spree
  class AbilityDecorator
    include CanCan::Ability
    def initialize(user)
      can :create, Address
      can :manage, Address do |address|
        (user.shipping_address && user.shipping_address == address) || (user.billing_address && user.billing_address == address)
      end
    end
  end

  Spree::Ability.register_ability(AbilityDecorator)
end
