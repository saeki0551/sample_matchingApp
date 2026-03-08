class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_information, dependent: :destroy

  # validates :email, :password, :password_confirmation, presence: true, on: [:crete]
  # VALID_PASSWORD_REGEX =/\A[a-zA-Z\d]+\w{6,12}\z/
  # validates :password,
  #           format: { with: VALID_PASSWORD_REGEX,
  #           message: "は半角6~12文字英数字である必要があります"}
  # validates :password, confirmation: { message: "パスワードが一致していません。" }

  validates_uniqueness_of :email, scope: :cancel_membership_count

  after_rollback :display_error_screen

  def display_error_screen
    Rails.logger.info
    raise StandardError
  end
  
  def self.already_sign_up?(email)
    User.exists?(email: email.values, is_deleted: false) 
  end

  def self.check_password(password)
    return "パスワード は英数字である必要があります。" unless /\A[a-zA-Z\d]+\z/.match(password.values[0])
    return "パスワード は6文字以上12文字以内である必要があります。" unless password.values[0].length >= 6 && password.values[0].length <= 12
    return "パスワード と パスワード確認 が一致していません。" unless password.values[0] == password.values[1]
  end

  def already_cancel_membership?(created_user, account_stop_time)
    return true if created_user.is_deleted && Time.zone.now - created_user.cancel_membership_time < account_stop_time
    return false if created_user.is_deleted && Time.zone.now - created_user.cancel_membership_time >= account_stop_time
  end

end
