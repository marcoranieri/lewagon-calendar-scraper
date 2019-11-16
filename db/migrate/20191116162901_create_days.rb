class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.string :date
      t.string :lecture
      t.string :colleagues, array: true, default: []
      t.text :html_row

      t.string :info, array: true, default: []

      t.references :batch, foreign_key: true

      t.timestamps
    end
  end
end
