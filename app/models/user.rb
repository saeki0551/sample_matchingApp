class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :user_information, dependent: :destroy  
  accepts_nested_attributes_for :user_information

  validates :email, :name, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true 
  
end