class UpdateDailyReportColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :daily_reports, :eno, :string
  end
end
