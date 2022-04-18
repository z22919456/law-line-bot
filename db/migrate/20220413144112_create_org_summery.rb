class CreateOrgSummery < ActiveRecord::Migration[6.0]
  def change
    create_table :org_summeries do |t|
      t.integer :need_reports
      t.integer :reported
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
