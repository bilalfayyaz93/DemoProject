class Cart < ApplicationRecord
  has_many :line_items
  def total_price
    total = line_items.each.sum { |product| product.total_price }
  end

  def discount_price(total)
    if(self.coupen_id)
      coupen = Coupen.find_by(id: self.coupen_id)

      (total.to_f*((100-coupen.discount).to_f/100)).round(2)
    else
      total
    end
  end
end
