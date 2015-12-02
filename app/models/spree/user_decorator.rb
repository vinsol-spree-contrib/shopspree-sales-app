Spree::User.class_eval do

  validates :full_name, presence: true

  has_many :authentications, class_name: 'Spree::UserAuthentication'

  before_save :set_confirmed_at, if: :authentication_exists?, unless: :confirmed_at?
  after_create :generate_spree_api_key!

  accepts_nested_attributes_for :authentications, allow_destroy: true

  def valid_social_login?(uid, provider)
    authentications.where(uid: uid, provider: provider).exists?
  end

  def confirmed?
    confirmed_at.present?
  end

  def authentication_exists?
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