class RemoveLikesFromLikedUserId < ActiveRecord::Migration[8.0]
  def change
    remove_column :likes, :liked_user_id
  end
end
