class Public::AddressesController < ApplicationController
  def index
    @customer = current_customer
    @address = Address.new
    @addresses = Address.all
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:notice] = "住所の登録が完了しました"
      redirect_to public_addresses_path
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

  private
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
