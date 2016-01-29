class Spree::SalesAppConfiguration < ActiveRecord::Base

  def self.get_latest_config
    config = first
    if config
      # see if any part is outdated
      if config.updated_at < Spree::Taxon.order(updated_at: :desc).first.updated_at
        config.taxonomies_checksum = generate_taxonomies_checksum
      end
      last_updated_state = Spree::State.where.not(updated_at: nil).order(updated_at: :desc).first
      if last_updated_state && config.updated_at < last_updated_state.updated_at
        config.states_checksum = generate_states_checksum
      end
      if config.updated_at < Spree::Banner.order(updated_at: :desc).first.updated_at
        config.home_checksum = generate_home_checksum
      end
    else
      config = new
      config.taxonomies_checksum = generate_taxonomies_checksum
      config.states_checksum = generate_states_checksum
      config.home_checksum = generate_home_checksum
    end
    config.save!
    config
  end

  def self.generate_taxonomies_checksum
    Digest::MD5.hexdigest(ActiveModel::ArraySerializer.new(
                                                           Spree::Taxonomy.order(:name).includes(:root => :children),
                                                           each_serializer: Spree::TaxonomySerializer, include_checksum: false ).to_json)
  end

  def self.generate_home_checksum
    Digest::MD5.hexdigest(Spree::HomeSerializer.new(Spree::HomeDecorator.new, include_checksum: false).to_json)
  end

  def self.generate_states_checksum
    Digest::MD5.hexdigest(Spree::CountryDetailsSerializer.new(Spree::Country.find(Spree::Config[:default_country_id]), include_checksum: false).to_json)
  end
end
