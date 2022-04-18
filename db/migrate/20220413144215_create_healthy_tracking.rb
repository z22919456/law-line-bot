class CreateHealthyTracking < ActiveRecord::Migration[6.0]
  def change
    create_table :healthy_trackings do |t|
      t.float :body_temperature
      t.string :foot_step
      t.string :health_feels_today
      t.string :health_feels_weeks
      t.string :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
