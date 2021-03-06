class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :coupon, optional: true
  belongs_to :user, optional: true

  def total_price
    total = line_items.each.sum { | product | product.total_price }
  end

  def discount_price(total)
    if self.coupon && self.coupon.expired?
      (total.to_f*((100-self.coupon.discount).to_f/100)).round(2)
    else
      total
    end
  end
end
