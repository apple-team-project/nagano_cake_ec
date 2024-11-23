class Admin::CustomersController < Admin::ApplicationsController

  def show
    @customer=Customer.find(params[:id])
  end   

  def index
    @customers=Customer.order(created_at: :asc).page(params[:page]).per(10)
  end   

  def edit
    @customer=Customer.find(params[:id])
  end 
  
  def update
    customer=Customer.find(params[:id])
    if customer.update(customer_params)
      redirect_to admin_customer_path(customer)
    else
      render "edit"  
    end
  end 
  
  private

  def customer_params
    params.require(:customer).permit(:first_name, :family_name, :first_name_kana, :family_name_kana, :post_code, :address, :phone_number, :email, :is_active)
  end  
end
