class Product < ApplicationRecord
  after_save ThinkingSphinx::RealTime.callback_for(:product)
  after_save :update_cart_record

  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :description, presence: true
  validates :price, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1,  only_integer: true }
  validates :photos, presence: true

  belongs_to :user

  has_many_attached :photos

  has_many :comments
  has_many :line_items, dependent: :destroy

  def update_cart_record
    line_items = LineItem.includes(:product).where(product_id: self.id)
    line_items.each do | item |
      if item.quantity > item.product.quantity
        item.quantity = item.product.quantity
        item.save
      end
    end
  end
end
