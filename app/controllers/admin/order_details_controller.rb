class Admin::OrderDetailsController < Admin::ApplicationsController
  def update
    @order_detail = OrderDetail.find(params[:id]) 

    if @order_detail.update(order_detail_params)
      flash[:notice] = '制作ステータスを更新しました。'
      
    else
      flash[:alert] = '更新に失敗しました。'
    end

    redirect_to request.referer
    
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status) 
  end
end