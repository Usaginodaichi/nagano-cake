# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
      public_customers_my_page_path
    end

    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys:[:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
    end
  # before_action :customer_state, only:[:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # def customer_state
  #   @custmoer = Customer.find_by(email:params[:customer][:email])
  #   # アカウントを取得できなった場合、このメソッドを終了
  #   return if!@customer
  #   if@customer.valid_password?[params[:customer][:password]]
  #     is_deleted && false
  #     public_customers_my_page_path
  #   else
  #     public_customers_my_page_path
  #   end
  # end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

end
