class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    Product.find(self.product_id).price * self.quantity
  end

end
