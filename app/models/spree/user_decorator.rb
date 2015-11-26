Spree::User.class_eval do

  validates :full_name, presence: true
  validators.each do |object|
    object.attributes.reject! {|field| field.to_s =~ /email/ } if object.kind == :uniqueness
  end

  has_one :authentication, class_name: 'Spree::UserAuthentication'

  before_save :set_confirmed_at, if: :social_authentication?
  after_create :generate_spree_api_key!

  validate :user_email, on: :create

  accepts_nested_attributes_for :authentication, allow_destroy: true

  def self.find_for_social_authentication(uid: uid, provider: provider)
    joins(:authentication).where(spree_user_authentications: { uid: uid, provider: provider } ).first
  end

  def confirmed?
    confirmed_at.present?
  end

  def social_authentication?
    try(:authentication).try(:present?) && try(:authentication).try(:social_login_provider?)
  end

  def password_required?
    if try(:authentication).try(:present?)
      false
    else
      super
    end
  end

  def provider
    try(:authentication).try(:provider)
  end

  def profile_pic_url
    try(:authentication).try(:profile_pic_url)
  end

  def valid_uid?(uid)
    authentication.uid == uid
  end

  private

  def user_email
    if Spree::User.where(email: self.email).joins(:authentication).where(spree_user_authentications: {provider: provider}).exists?
      errors.add(:email, 'Email already exists')
    end
  end

    def set_confirmed_at
      self.confirmed_at = Time.current
    end

end