class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy       

  def full_name
    "#{family_name} #{first_name}"
  end 
       
  def address_all
    "〒" + post_code + " " + address
  end

end
