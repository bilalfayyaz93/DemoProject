class SoldProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def total_price
    price = self.price * self.quantity
  end

end
