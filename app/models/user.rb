class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable
  
  has_one :user_information, dependent: :destroy

  validates_uniqueness_of :email, scope: :deleted_at

  def already_sign_up?(email)
    User.exists?(email: email.values, deleted_at: nil) 
  end
  
  def check_password(**password)
    return "パスワード は英数字である必要があります。" unless /\A[a-zA-Z\d]+\z/.match(password[:password])
    return "パスワード は6文字以上12文字以内である必要があります。" unless password[:password].length >= 6 && password[:password].length <= 12
    return "パスワード と パスワード確認 が一致していません。" unless password[:password] == password[:password_confirmation]
  end
  
  def sort_created_user(email)
    User.order(deleted_at: :desc).find_by(email: email.values)
  end

  def in_time_cancel_membership?(account_stop_time)
    Time.zone.now - self.deleted_at < account_stop_time[:account_stop_time] 
  end

  def get_latest_user(sign_in_params)
    User.order(id: :desc).find_by(email: sign_in_params[:email])
  end
end
