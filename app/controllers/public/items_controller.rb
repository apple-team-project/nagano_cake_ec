class Public::ItemsController < Public::ApplicationController
  skip_before_action :authenticate_customer!

  def index
  @items = Item.page(params[:page])
  end

  def show
  @item = Item.find(params[:id])
  @cart_item = CartItem.new
  end 

end 
