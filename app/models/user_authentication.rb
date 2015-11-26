module Spree
  class UserAuthentication < ActiveRecord::Base

    SOCIAL_LOGIN_PROVIDERS = ['Facebook', 'Google']

    validates :uid, presence: true
    validates :provider, inclusion: { in: SOCIAL_LOGIN_PROVIDERS, message: 'Provider must be Facebook or Google' }

    belongs_to :user, class_name: 'Spree::User'

    def social_login_provider?
      SOCIAL_LOGIN_PROVIDERS.include?(provider)
    end

  end

end