class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details, dependent: :destroy
  # 注文個数（amountの合計）を計算するメソッド
  def total_amount
    order_details.sum(:amount)
  end

  enum payment_method: { credit_card: 0, cash: 1 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, making: 2, delivery_preparation: 3, delivered: 4 }

  # 日本語のステータスを返すメソッドを追加
def status_in_japanese
  case status
  when "payment_waiting"
    "入金待ち"
  when "payment_confirmation"
    "入金確認"
  when "making"
    "製作中"
  when "delivery_preparation"
    "発送準備中"
  when "delivered"
    "発送済"
  else
    "不明"
  end
end

  def total_price
    shipping_fee + total_payment
  end
end
