class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_one :user_information, dependent: :destroy

  validates :email, :password, :password_confirmation, presence: true, on: [:crete]
  validates_uniqueness_of :email, scope: :cancel_membership_count

  after_rollback :display_error_screen

  def display_error_screen
    Rails.logger.info
    raise StandardError
  end
  
  def check_password
    return "パスワード は英数字である必要があります。" unless /\A[a-zA-Z\d]+\z/.match(self.password)
    return "パスワード は6文字以上12文字以内である必要があります。" unless self.password.length >= 6 && self.password.length <= 12
    return "パスワード と パスワード確認 が一致していません。" unless self.password == self.password_confirmation 
  end

  def already_sign_up?
    User.exists?(email: self.email, is_deleted: false) 
  end

  def already_cancel_membership?
    if created_user = User.order(updated_at: :desc).limit(1).select(:is_deleted, :cancel_membership_count, :cancel_membership_time).find_by(email: self.email, is_deleted: true)
      if created_user.is_deleted && Time.zone.now - created_user.cancel_membership_time < ACCOUNT_STOP_TIME
        return "新規登録できませんでした。ログインするか、#{ACCOUNT_STOP_TIME} 秒後に新規登録してください。" 
      else
        return false if created_user.is_deleted && Time.zone.now - created_user.cancel_membership_time >= ACCOUNT_STOP_TIME
      end
    end
  end
end
