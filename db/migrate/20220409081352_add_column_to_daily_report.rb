class AddColumnToDailyReport < ActiveRecord::Migration[6.0]
  def change
    add_column :daily_reports, :touch_date, :Date
    add_column :daily_reports, :touch_location, :string
  end
end
