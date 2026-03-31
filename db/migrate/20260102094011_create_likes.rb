class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.integer :current_user_id, null: false
      t.timestamps
    end
  end
end