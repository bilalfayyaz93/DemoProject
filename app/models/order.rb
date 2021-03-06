class Order < ApplicationRecord
  belongs_to :user
  belongs_to :coupon, optional: true

  has_many :sold_products, dependent: :destroy

  def total_price
    sold_products.each.sum { |product| product.total_price }
  end

  def discount_price(total)
    if self.coupon
      (total.to_f*((100-self.coupon.discount).to_f/100)).round(2)
    else
      total
    end
  end
end
