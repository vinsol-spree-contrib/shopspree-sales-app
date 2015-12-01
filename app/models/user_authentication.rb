module Spree
  class UserAuthentication < ActiveRecord::Base

    SOCIAL_LOGIN_PROVIDERS = ['Facebook', 'Google']

    validates :uid, presence: true
    validates :provider, inclusion: { in: SOCIAL_LOGIN_PROVIDERS, 
              message: "Provider must be #{ SOCIAL_LOGIN_PROVIDERS.to_sentence(last_word_connector: ' or ') }" }
    validates :uid, uniqueness: { scope: :provider, allow_blank: true }

    belongs_to :user, class_name: 'Spree::User'

  end

end