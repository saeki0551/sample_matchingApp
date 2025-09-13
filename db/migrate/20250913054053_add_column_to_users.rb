class AddColumnToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :age, :integer 
    add_column :users, :birth_date, :date
    add_column :users, :prefecture_id, :integer 
    add_column :users, :hobby_id, :integer 
  end
end
