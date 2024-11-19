class Public::ItemsController < ApplicationController

 def index
  @items = Item.page(params[:page])
 end

 def show
  @item = Item.find(params[:id])
  @cart_item = current_customer.cart_items.new
 end 

end 
