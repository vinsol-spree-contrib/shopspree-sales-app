module Spree
  class UserAuthentication < ActiveRecord::Base

    SOCIAL_LOGIN_PROVIDERS = ['Facebook', 'Google']
    LOGIN_PROVIDERS = ['ShopSpree'].concat(SOCIAL_LOGIN_PROVIDERS)

    validates :uid, presence: true, if: :social_login_provider?
    validates :provider, inclusion: { in: LOGIN_PROVIDERS, message: 'Provider must be Facebook/Google/ShopSpree' }
    validates :uid, uniqueness: { scope: :provider, message: 'Email already exits' }

    belongs_to :user, class_name: 'Spree::User'

    def social_login_provider?
      SOCIAL_LOGIN_PROVIDERS.include?(provider)
    end

  end

end