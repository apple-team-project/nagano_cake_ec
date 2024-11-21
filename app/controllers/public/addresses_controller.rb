class Public::AddressesController < ApplicationController
  def index
    @addresses = current_customer.addresses
    @address = current_customer.addresses.build
  end

  def create
    @address = current_customer.addresses.build(address_params)
    if @address.save
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses
      render :index
    end
  end

  def edit
    @address = current_customer.addresses.find(params[:id])
  end

  def update
    @address = current_customer.addresses.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    address = current_customer.addresses.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end
end
