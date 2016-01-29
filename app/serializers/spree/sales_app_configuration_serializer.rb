module Spree
  # initialized with a configuration hash
  class SalesAppConfigurationSerializer < ActiveModel::Serializer
    attributes :states_checksum, :home_checksum, :taxonomies_checksum
  end
end
