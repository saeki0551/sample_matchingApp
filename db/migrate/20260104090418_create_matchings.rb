class CreateMatchings < ActiveRecord::Migration[8.0]
  def change
    create_table :matchings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :like, null: false, foreign_key: true

      t.timestamps
    end
  end
end
