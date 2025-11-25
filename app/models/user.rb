class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  
  has_one :user_information, dependent: :destroy  

  validates :email, :name, :password, :password_confirmation, presence: true, on: [:crete] 
  validates_uniqueness_of :email, scope: :cancel_membership_count
 
  def check_password
    return "Password は英数字である必要があります。" unless /\A[a-zA-Z\d]+\z/.match(self.password)
    return "Password は6文字以上12文字以内である必要があります。" unless self.password.length >= 6 && self.password.length <= 12
    return "Password と Password confirmation が一致していません。" unless self.password == self.password_confirmation 
  end
end