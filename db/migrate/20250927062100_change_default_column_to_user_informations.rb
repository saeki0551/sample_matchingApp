class ChangeDefaultColumnToUserInformations < ActiveRecord::Migration[8.0]
  def change
    change_column :user_informations, :age, :integer, default: 30, null: false
    change_column :user_informations, :birth_date, :date, default: "1995-01-01", null: false
    change_column :user_informations, :prefecture_id, :integer, default: 13, null: false
    change_column :user_informations, :hobby_id, :integer, default: 1, null: false
  end
end