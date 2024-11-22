class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @orders = Order.page(params[:page]).per(10) # 1ページ10件
  end
   
  def update
    @order = Order.find(params[:id])
 
    if @order.update(order_params)
      flash.now[:notice] = '注文ステータスを更新しました。'
      
    else
      flash.now[:alert] = '更新に失敗しました。'
    end
      
    redirect_to request.referer
  end

 private

  def order_params
    params.require(:order).permit(:status) # 注文ステータスを許可
  end
 
end
