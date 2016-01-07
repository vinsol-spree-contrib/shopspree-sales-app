class Spree::Device < ActiveRecord::Base

  belongs_to :user, class_name: Spree.user_class.to_s
  validates :device_token, presence: true

  # Unlink the user_id from device id
  def unlink
    self.user_id = nil
    self.save
  end

end
