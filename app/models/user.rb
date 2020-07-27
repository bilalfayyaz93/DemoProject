class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :display_picture
<<<<<<< HEAD
=======
  has_many :comments
  has_many :orders
  has_many :products
  has_one :cart
>>>>>>> 38e3601b1fb887ff3a37553593f13914a8cdb188
end
