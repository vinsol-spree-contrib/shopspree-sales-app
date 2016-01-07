class Spree::DeviceAbility
  include CanCan::Ability

  def initialize(user)
    can :unlink, Spree::Device do |device|
      device.user_id && device.user_id = user.id
    end

    can :deregister, Spree::Device do |device|
      device.user_id && device.user_id = user.id
    end
  end
end
