class AddColumnToOrganization < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :is_sales, :boolean
  end
end
