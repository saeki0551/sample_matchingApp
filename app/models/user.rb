class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :user_information, dependent: :destroy  

  validates :email, :name, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true 
  # 英数字のみ許可
  validates :password, :password_confirmation, format: { with: /\A[a-zA-Z\d]+\z/, message: 'は英数字である必要があります'}
  # validates :password, :password_confirmation, length: { minimum: 5 , message: 'は6文字以上である必要があります'}

end