class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :liked_user
      t.timestamps
    end
    add_foreign_key :likes, :users, column: :liked_user_id
  end
end