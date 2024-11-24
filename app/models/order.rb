class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details, dependent: :destroy

  validates :payment_method, presence: true
  validates :post_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :shipping_fee, presence: true
  validates :total_payment, presence: true
  validates :status, presence: true

  enum payment_method: { credit_card: 0, cash: 1 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, making: 2, delivery_preparation: 3, delivered: 4 }

  after_update :update_making_status, if: :saved_change_to_status?

  # 注文個数（amountの合計）を計算するメソッド
  def total_amount
    order_details.sum(:amount)
  end

  def total_price
    shipping_fee + total_payment
  end

  private

  def update_making_status
    return unless order_details

    if status == 'payment_confirmation'
      order_details.update(making_status: 'make_pending')
    end
  end
end
