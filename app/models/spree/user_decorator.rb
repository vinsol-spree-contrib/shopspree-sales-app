Spree::User.class_eval do

  SOCIAL_LOGIN_TYPE = ['Facebook', 'Google']

  validates :full_name, presence: true
  validates :login_type, inclusion: { in: SOCIAL_LOGIN_TYPE, message: 'Login Type must be Facebook or Google', allow_blank: true }
  validates :uid, presence: true, if: :valid_login_type?

  before_save :set_confirmed_at, if: :valid_login_type?

  def confirmed?
    confirmed_at.present?
  end

  def valid_login_type?
    SOCIAL_LOGIN_TYPE.include?(self.login_type)
  end

  def password_required?
    if valid_login_type?
      false
    else
      super
    end
  end

  def valid_uid?(uid)
    self.uid == uid
  end

  private

    def set_confirmed_at
      self.confirmed_at = Time.current
    end

end