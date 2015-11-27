# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
end

Spree.user_class = "Spree::LegacyUser"

attachment_config = {
  s3_credentials: {
    access_key_id: ENV['AWS_ACCESS_KEY'],
    secret_access_key: ENV['AWS_SECRET_TOKEN'],
    bucket: ENV['AWS_BUCKET']
  },

  storage:        :s3,
  s3_protocol:    "https"
}

if Rails.env.production? || Rails.env.staging?
  Paperclip::Attachment.default_options[:s3_protocol] = "https"

  attachment_config.each do |key, value|
    Spree::Image.attachment_definitions[:attachment][key.to_sym] = value
    Spree::Taxon.attachment_definitions[:icon][key.to_sym] = value
    Spree::Banner.attachment_definitions[:image][key.to_sym] = value
  end
end


Spree::Image.attachment_definitions[:attachment][:path] = '/spree/products/:id/:style/:basename.:extension'
Spree::Taxon.attachment_definitions[:icon][:path] = '/spree/products/:id/:style/:basename.:extension'
Spree::Banner.attachment_definitions[:image][:path] = '/spree/banners/:id/:style/:basename.:extension'
Spree::Auth::Config[:confirmable] = true
