module Spree
  class UserSerializer < ActiveModel::Serializer
    root false
    attributes :id,
               :email,
               :full_name,
               :spree_api_key,
               :profile_pic_url,
               :confirmed

    def confirmed
      object.confirmed?
    end
    
  end
end
