class ChangUserCompanyType < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :company, :string
  end
end
