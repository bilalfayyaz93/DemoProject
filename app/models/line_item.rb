class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  attr_accessor :total_price
  def total_price
    Product.find(self.product_id).price * self.quantity
  end

end
