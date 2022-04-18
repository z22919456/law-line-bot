class AddNewColumnToDailyReport < ActiveRecord::Migration[6.0]
  def change
    add_column :daily_reports, :need_tracking_till, :date
  end
end
