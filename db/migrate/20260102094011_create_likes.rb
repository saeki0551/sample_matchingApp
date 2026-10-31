class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true, null: false
      t.references :liked_user, foreign_key: { to_table: :users }, null: false
      t.check_constraint "user_id != liked_user_id", name: "check_self_like"
      t.timestamps
    end
  end
end
