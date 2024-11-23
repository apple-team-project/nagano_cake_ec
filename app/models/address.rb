class Address < ApplicationRecord
  belongs_to :customer

  validates :name, presence: true, length: { maximum: 50 }
  validates :post_code, presence: true, format: { with: /\A\d{7}\z/, message: "は7桁の数字で入力してください" }
  validates :address, presence: true, length: { maximum: 200 }

  def address_display
    '〒' + post_code + ' ' + address + ' ' + name
  end
end
