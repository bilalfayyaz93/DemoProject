class Cart < ApplicationRecord
  has_many :line_items
  def total_price
    line_items.each.sum {|product| product.total_price}
  end
end
