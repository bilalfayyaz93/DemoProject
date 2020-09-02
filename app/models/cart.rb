class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :coupen, optional: true
  belongs_to :user, optional: true

  def total_price
    total = line_items.each.sum { | product | product.total_price }
  end

  def discount_price(total)
    if self.coupen && self.coupen.expirey > DateTime.now
      10
    else
      20
    end
  end
end
