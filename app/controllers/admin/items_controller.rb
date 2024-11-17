class Admin::ItemsController < ApplicationController

  def show
    @item=Item.find(params[:id])
  end 
  
  def edit
    @item=Item.find(params:id)
  end 
  
  def update
    item=Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_item_path(item)
  end   

  private
   def item_params
    params.require(:item).permit(:item_image, :name, :description, :genre_id, :price, :is_active)
   end  
end
