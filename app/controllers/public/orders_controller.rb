class Public::OrdersController < ApplicationController
  def new
  end

  def create
  end

  def index
    @orders = current_customer.orders.includes(order_details: :items)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end

  def confirm_order
  end

  def complete_order
  end
end
