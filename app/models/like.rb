class Like < ApplicationRecord
  belongs_to :user

  def sort_matching_users
    Like.find_by(user_id: self.liked_user_id, liked_user_id: self.user_id)
  end
end
