class AddServiceTypeToSpreeDevices < ActiveRecord::Migration
  def change
    add_column :spree_devices, :service_type, :integer
  end
end
