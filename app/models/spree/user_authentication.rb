module Spree
  class UserAuthentication < ActiveRecord::Base

    SOCIAL_LOGIN_PROVIDERS = ['Facebook', 'Google']

    validates :uid, presence: true
    validates :provider, inclusion: { in: SOCIAL_LOGIN_PROVIDERS, message: 'Provider must be Facebook or Google' }
    validates :uid, uniqueness: { scope: :provider, allow_blank: true }

    belongs_to :user, class_name: 'Spree::User'

  end

end
