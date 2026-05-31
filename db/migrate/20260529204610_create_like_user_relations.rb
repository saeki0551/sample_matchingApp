class CreateLikeUserRelations < ActiveRecord::Migration[8.0]
  def change
    create_table :like_user_relations do |t|
      t.timestamps
      t.references :user, foreign_key: true
      t.references :like, foreign_key: true
    end
  end
end
