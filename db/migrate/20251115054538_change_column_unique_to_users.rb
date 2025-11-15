class ChangeColumnUniqueToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :cancel_membership_count, :integer, null:false, default:0
    add_column :users, :cancel_membership_time, :datetime
    add_index :users, [:email, :cancel_membership_count], unique: true
  end
end
