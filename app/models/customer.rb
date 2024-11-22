class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy    
  
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :post_code, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  

  def full_name
    "#{family_name} #{first_name}"
  end 
       
  def address_all
    "〒" + post_code + " " + address
  end

end
