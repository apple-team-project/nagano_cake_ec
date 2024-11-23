class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  before_action :authenticate_customer!, only: [:destroy]

  protected

  def customer_state
    customer = Customer.find_by(email: params[:customer][:email])
    return if customer.nil?
    return unless customer.valid_password?(params[:customer][:password])
    if customer.is_active == false
      redirect_to new_customer_registration_path and return
    end 
  end    

  def after_sign_in_path_for(resource)
    root_path
  end 
  
  def after_sign_out_path_for(resource)
    root_path
  end  

end
