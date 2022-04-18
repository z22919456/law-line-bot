class AddOrganizationIdColumnToDailyReport < ActiveRecord::Migration[6.0]
  def change
    add_reference :daily_reports, :organization, index: true
    add_column :daily_reports, :eno, :integer, index: true
  end
end
