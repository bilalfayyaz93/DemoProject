class Order < ApplicationRecord
  belongs_to :user
  belongs_to :coupen, optional: true

  has_many :sold_products

  def sub_total
    sold_products.each.sum {|product| product.total_price}
  end
end
