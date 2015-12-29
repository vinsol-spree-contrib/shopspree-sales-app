class Spree::CreditCardAbility
  include CanCan::Ability

  def initialize(user)
    can :create, Spree::CreditCard
    can :manage, Spree::CreditCard do |credit_card|
      credit_card.user_id && credit_card.user_id = user.id
    end
  end
end
