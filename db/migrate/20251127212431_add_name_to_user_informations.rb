class AddNameToUserInformations < ActiveRecord::Migration[8.0]
  def change
    add_column :user_informations, :name, :string, null: false
  end
end
