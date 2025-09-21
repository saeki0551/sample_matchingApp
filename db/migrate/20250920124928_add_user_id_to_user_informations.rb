class AddUserIdToUserInformations < ActiveRecord::Migration[8.0]
  def change
    add_reference :user_informations, :user, foreign_key: true
  end
end
