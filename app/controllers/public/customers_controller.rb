class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to mypage_customers_path
    else
      render :edit
    end
  end

  def confirm_leave
  end

  def leave
    customer = current_customer
    if customer.update(is_active: false)
      reset_session
      redirect_to root_path
    else
      render :confirm_leave
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :address, :phone_number, :email)
  end

end
