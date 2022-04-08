class CreateDailyReport < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_reports do |t|
      t.references :user, index: true
      t.string :answered
      t.timestamps
    end
  end
end
