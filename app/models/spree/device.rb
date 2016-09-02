class Spree::Device < ActiveRecord::Base

  SERVICE_TYPES = { android: 0, ios: 1 }

  belongs_to :user, class_name: Spree.user_class.to_s
  validates :device_token, :service_type, presence: true
  validates :service_type, inclusion: { in: SERVICE_TYPES.values }, allow_blank: true

  # Unlink the user_id from device id
  def unlink
    self.user_id = nil
    save
  end

  def service_type=(value)
    self.service_type = SERVICE_TYPES[value.to_sym]
  end

  def service_type_title
    SERVICE_TYPES.key(service_type)
  end
end
