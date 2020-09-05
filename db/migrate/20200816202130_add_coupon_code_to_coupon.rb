class AddCouponCodeToCoupon < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :coupon_code, :string, null: false
    add_index :coupons, :coupon_code, unique: true
  end
end
