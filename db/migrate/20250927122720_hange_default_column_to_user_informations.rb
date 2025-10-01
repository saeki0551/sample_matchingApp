class HangeDefaultColumnToUserInformations < ActiveRecord::Migration[8.0]
  def up
    change_column :user_informations, :age, :integer, null: false
    change_column :user_informations, :birth_date, :date, null: false
    change_column :user_informations, :prefecture_id, :integer, null: false
    change_column :user_informations, :hobby_id, :integer, null: false
  end
  
  def down
    change_column :user_informations, :age, :integer, default: 30, null: false
    change_column :user_informations, :birth_date, :date, default: "1995-01-01", null: false
    change_column :user_informations, :prefecture_id, :integer, default: 13, null: false
    change_column :user_informations, :hobby_id, :integer, default: 1, null: false
  end
end
