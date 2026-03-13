class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_one :user_information, dependent: :destroy

  # validates_uniqueness_of :email, scope: :cancel_membership_count

  after_rollback :display_error_screen

  def display_error_screen
    Rails.logger.info
    raise StandardError
  end
  
  def self.already_sign_up?(email)
    User.exists?(email: email.values, deleted_at: false) 
  end

  def self.check_password(password)
    return "パスワード は英数字である必要があります。" unless /\A[a-zA-Z\d]+\z/.match(password.values[0])
    return "パスワード は6文字以上12文字以内である必要があります。" unless password.values[0].length >= 6 && password.values[0].length <= 12
    return "パスワード と パスワード確認 が一致していません。" unless password.values[0] == password.values[1]
  end

  def self.in_time_cancel_membership?(deleted_at, account_stop_time)
    return true if deleted_at && Time.zone.now - deleted_at < account_stop_time
  end

end
