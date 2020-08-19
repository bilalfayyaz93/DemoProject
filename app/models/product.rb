class Product < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :description, presence: true
  validates :price, presence: true
  validates :quantity, presence: true

  belongs_to :user

  has_many_attached :photos

  has_many :comments
  has_many :line_items, dependent: :destroy
end
