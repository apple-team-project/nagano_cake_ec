class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new 
  end
  
  def create
    item = Item.new(item_params)
    if item.save
      redirect_to admin_item_path(item)
    else
      render :new
    end
  end   

  def index
    @items = Item.includes(:genre).order(created_at: :asc).page(params[:page]).per(10)
  end   


  def show
    @item = Item.includes(:genre).find(params[:id])
    @genre = @item.genre
  end 
  
  def edit
    @item = Item.find(params[:id])
  end 
  
  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_item_path(item)
  end   

  private
   def item_params
    params.require(:item).permit(:item_image, :name, :description, :genre_id, :price, :is_active)
   end  
end
