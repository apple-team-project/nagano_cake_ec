class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy    
  
  validates :family_name, presence: true, length: { maximum: 50 }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :family_name_kana, presence: true, length: { maximum: 50 } 
  validates :first_name_kana, presence: true, length: { maximum: 50 }
  validates :post_code, presence: true, format: { with: /\A\d{7}\z/, message: "は7桁の数字で入力してください" }
  validates :address, presence: true, length: { maximum: 200 }
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: "は10桁または11桁の数字で入力してください" }

  validates :email, presence: true, uniqueness: true
  validates :is_active, inclusion: { in: [true, false] }
  
  def full_name
    "#{family_name} #{first_name}"
  end 
       
  def address_all
    "〒" + post_code + " " + address
  end

end
