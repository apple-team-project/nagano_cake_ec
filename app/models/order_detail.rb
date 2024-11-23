class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :amount, presence: true
  validates :price, presence: true
  validates :making_status, presence: true
  
  enum making_status: { start_not_possible: 0, make_pending: 1, making: 2, make_complete: 3 }

  def subtotal
    price * amount
  end
end
