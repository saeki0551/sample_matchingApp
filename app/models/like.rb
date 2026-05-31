class Like < ApplicationRecord
  belongs_to :user
  has_many :like_user_relations
  has_many :users, through: :like_user_relations, dependent: :destroy
end
