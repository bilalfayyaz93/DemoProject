class User < ApplicationRecord
  attr_accessor :remove_avatar

  has_one_attached :avatar

  has_many :comments
  has_many :orders
  has_many :products

  has_one :cart

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_save :purge_avatar, if: :remove_avatar

  def purge_avatar
    self.avatar.purge_later
  end
end
