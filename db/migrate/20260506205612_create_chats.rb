class CreateChats < ActiveRecord::Migration[8.0]
  def change
    create_table :chats do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :chatting_user_id, null: false
      t.string :text
      
      t.timestamps
    end
  end
end
