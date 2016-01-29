module Spree
  class HomeSerializer < ActiveModel::Serializer
    root false
    attributes :checksum
    has_many :banner_types

    def checksum
      unless options[:include_checksum] == false
        Spree::SalesAppConfiguration.get_latest_config.home_checksum
      end
    end
  end
end
