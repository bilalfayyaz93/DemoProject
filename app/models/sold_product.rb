class SoldProduct < ApplicationRecord
  belongs_to :order

  def total_price
    price = Product.find(self.product_id).price * self.quantity
  end

end
