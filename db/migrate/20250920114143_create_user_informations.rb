class CreateUserInformations < ActiveRecord::Migration[8.0]
  def change
    create_table :user_informations do |t|
      t.integer :age, null: false
      t.date :birth_date, null: false
      t.integer :prefecture_id, null: false
      t.integer :hobby_id, null: false

      t.timestamps
    end
  end
end
