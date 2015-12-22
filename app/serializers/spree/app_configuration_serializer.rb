module Spree
  # initialized with a configuration hash
  class AppConfigurationSerializer < ActiveModel::Serializer
    attributes :country_details, :checksum

    def country_details
      # currently only us is supported
      CountryDetailsSerializer.new(object[:countries][0])
    end

    def checksum
      Digest::MD5.hexdigest(object.to_s)
    end
  end
end
