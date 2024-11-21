class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
   
  def update
    @order = Order.find(params[:id])
 
    if @order.update(order_params)
      flash.now[:notice] = '注文ステータスを更新しました。'
      redirect_to request.referer
    else
      flash.now[:alert] = '更新に失敗しました。'
    end
      
      
  end

 private

  def order_params
    params.require(:order).permit(:status) # 注文ステータスを許可
  end
 
end
