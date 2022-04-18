class CreateFootprint < ActiveRecord::Migration[6.0]
  def change
    create_table :footprints do |t|
      t.string :pdf_url
      t.string :note

      t.timestamps
    end
  end
end
