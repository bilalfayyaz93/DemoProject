class CreateSoldProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :sold_products do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
