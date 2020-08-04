class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attr_accessor :remove_avator

  after_save :purge_avator, if: :remove_avator
  def purge_avator
    self.avator.purge_later
  end



  has_one_attached :avator
  has_many :comments
  has_many :orders
  has_many :products
  has_one :cart
end
