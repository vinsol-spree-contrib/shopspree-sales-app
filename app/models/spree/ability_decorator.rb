module Spree
  class AbilityDecorator
    include CanCan::Ability
    def initialize(user)
      can :create, Address
      can :manage, Address do |address|
        user.addresses.include?(address)
      end
    end
  end

  Spree::Ability.register_ability(AbilityDecorator)
end
