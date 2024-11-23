class Admin::HomesController < Admin::ApplicationsController
  def top
   @orders = Order.includes(:customer, :order_details).order(created_at: :desc)
   @orders = Order.page(params[:page]).per(10) # 1ページに10件表示
  end  
end
