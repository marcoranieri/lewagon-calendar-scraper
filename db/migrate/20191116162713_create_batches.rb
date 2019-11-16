class CreateBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :batches do |t|
      t.integer :number
      t.string :city
      t.text :notes
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
