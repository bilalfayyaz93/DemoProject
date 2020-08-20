class Coupen < ApplicationRecord
  validates :coupen_code, presence: true, length: {minimum:3}

  has_many :orders
end
