module Spree
  class AbilityDecorator
    include CanCan::Ability
    def initialize(user)
      debugger
      can :manage, Address

    end
  end

  Spree::Ability.register_ability(AbilityDecorator)
end
