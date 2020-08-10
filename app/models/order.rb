class Order < ApplicationRecord
  belongs_to :user
  has_many :sold_products

  def sub_total
    sold_products.each.sum {|product| product.total_price}
  end
end
