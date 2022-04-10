class AddRoleColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :integer
    remove_column :users, :manager_id, :integer
    remove_column :users, :is_sales, :integer
  end
end
