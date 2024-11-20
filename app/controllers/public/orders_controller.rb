class Public::OrdersController < ApplicationController
  def new
    @order = current_customer.orders.build
  end

  def create
    @order = current_customer.orders.build(order_params)
    @cart_items = current_customer.cart_items.includes(:item)
    if @order.save
      @cart_items.each do |cart_item|
        @order.order_details.create(
          item_id: cart_item.item_id,
          amount: cart_item.amount,
          price: cart_item.item.add_tax_price
        )
      end
      @cart_items.destroy_all
      redirect_to complete_order_orders_path
    else
      render :confirm_order
    end
  end

  def index
    @orders = current_customer.orders.includes(order_details: :items)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end

  def confirm_order
    @order = current_customer.orders.build(order_params.except(:address_id, :address_select))
    @order.shipping_fee = 800 # 送料の設定の流れが不明だったため、仮で800円に設定
    @cart_items = current_customer.cart_items.includes(:item)
    case params[:order][:address_select]
    when "customer_address"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    when "address_list"
      address = current_customer.addresses.find(params[:order][:address_id])
      @order.post_code = address.post_code
      @order.address = address.address
      @order.name = address.name
    when "new_address"
      # 新しいお届け先を使用
      # 送信されたフォームのデータをそのまま使用
    else
      render :new
    end
  end

  def complete_order
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :shipping_fee, :total_payment)
  end
end
