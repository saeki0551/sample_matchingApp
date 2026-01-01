class AddGenderToUserInformations < ActiveRecord::Migration[8.0]
  def change
    add_column :user_informations, :gender, :interger, default: 0, null: false
  end
end
