class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :amount, presence: true
  validates :price, presence: true
  validates :making_status, presence: true
  
  enum making_status: { start_not_possible: 0, make_pending: 1, making: 2, make_complete: 3 }

  after_update :update_order_status, if: :saved_change_to_making_status?

  def subtotal
    price * amount
  end

  private

  def update_order_status
    order = self.order
    if order.order_details.all? { |order_detail| order_detail.make_complete? }
      order.update(status: 3)
    elsif order.order_details.any? { |order_detail| order_detail.making? }
      order.update(status: 2)
    end
  end
end
