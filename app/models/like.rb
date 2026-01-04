class Like < ApplicationRecord
  belongs_to :user
  has_many :matchings
  has_many :users, through: :matchings
end
