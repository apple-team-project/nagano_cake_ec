class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items
      render :index
    end
  end

  def create
    @cart_item = current_customer.cart_items.find_or_initialize_by(item_id: cart_item_params[:item_id])
    if @cart_item.new_record?
      @cart_item.amount = cart_item_params[:amount]
    else
      @cart_item.amount += cart_item_params[:amount].to_i
    end
  
    if @cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find(cart_item_params[:item_id])
      redirect_to item_path(@item)
    end
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = current_customer.cart_items
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
