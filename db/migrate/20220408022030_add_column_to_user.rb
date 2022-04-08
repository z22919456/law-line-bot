class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :organization, index: true
    add_column :users, :real_name, :string
  end
end
