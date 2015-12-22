module Spree
  # initialized with a configuration hash
  class AppConfigurationSerializer < ActiveModel::Serializer
    attributes :country_details, :checksum

    def country_details
      Spree::CountryDetailsSerializer.new(object[:country_details])
    end

    def checksum
      Digest::MD5.hexdigest(object.to_s)
    end
  end
end
