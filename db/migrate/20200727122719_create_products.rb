class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :quantity, default: 0
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
