class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  # 注文個数（amountの合計）を計算するメソッド
  def total_amoount
    order_details.sum(:amount)
  end

  enum payment_method: { credit_card: 0, cash: 1 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, making: 2, delivery_preparation: 3, delivered: 4 }

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details, dependent: :destroy

  def total_price
    shipping_fee + total_payment
  end
end
