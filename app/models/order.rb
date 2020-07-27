class Order < ApplicationRecord
  belongs_to :user
  belongs_to :coupen
  has_many :sold_products
end
