class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.integer :discount, validates: { length: 3 }
      t.date :expiry

      t.timestamps
    end
  end
end
