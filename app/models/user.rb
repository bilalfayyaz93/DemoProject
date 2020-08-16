class User < ApplicationRecord
  attr_accessor :remove_avator

  has_one_attached :avator

  has_many :comments
  has_many :orders
  has_many :products

  has_one :cart

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

     after_save :purge_avator, if: :remove_avator

  def purge_avator
    self.avator.purge_later
  end
end
