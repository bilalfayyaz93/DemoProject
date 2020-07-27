class CreateCoupens < ActiveRecord::Migration[6.0]
  def change
    create_table :coupens do |t|
      t.integer :discount, validates: { length: 3, format: /^[1-9][0-9]?$|^100$/ }#not working :))
      t.date :expirey

      t.timestamps
    end
  end
end
