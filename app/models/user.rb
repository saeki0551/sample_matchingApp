class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :user_information, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true 

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

  def already_liked?(current_user_id, user_id)
    if self.likes.exists?(user_id: current_user_id, liked_user_id: user_id)
      return self.likes.find_by(user_id: current_user_id, liked_user_id: user_id)
    end
  end
end
