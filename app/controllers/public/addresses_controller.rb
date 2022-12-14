class Public::AddressesController < ApplicationController
  def index
    @customer = current_customer
    @address = Address.new
    @address.customer_id = current_customer.id
    @addresses = current_customer.addresses.all
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = "住所の登録が完了しました"
      redirect_to public_addresses_path(@address.id)
    else
      render :index
    end
  end

  def edit
    @customer = current_customer
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "住所の変更が完了しました"
      redirect_to public_addresses_path
    else
      render :index
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    flash[:notice] = "配送先を削除いたしました"
    redirect_to public_addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
