module Spree
  class CountryDetailsSerializer < ActiveModel::Serializer
    attributes :id, :name, :iso, :checksum

    has_many :states, serializer: Spree::StateSerializer

    def checksum
      unless options[:exclude_checksum]
        Spree::SalesAppConfiguration.get_latest_config.states_checksum
      end
    end

  end
end
