Spree::User.class_eval do

  has_many :authentications, class_name: 'Spree::UserAuthentication', dependent: :destroy
  has_many :devices, class_name: 'Spree::Device'

  before_save :set_confirmed_at, if: :social_authentication?
  after_create :generate_spree_api_key!

  accepts_nested_attributes_for :authentications, allow_destroy: true

  def valid_social_login?(uid, provider)
    authentications.where(uid: uid, provider: provider).exists?
  end

  def confirmed?
    confirmed_at.present?
  end

  def social_authentication?
    authentications.any?
  end

  def password_required?
    if authentications.any?
      false
    else
      super
    end
  end

  private

    def set_confirmed_at
      self.confirmed_at = Time.current
    end

end
