class Coupon < ApplicationRecord
  validates :coupon_code, presence: true, length: {minimum:3}

  has_many :orders


  def expired?
    DateTime.now < self.expiry
  end
end
