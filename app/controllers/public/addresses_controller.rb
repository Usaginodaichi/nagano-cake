class Public::AddressesController < ApplicationController
  def index
    @customer = current_customer
    @address = Address.new
    @addresses = Address.find(params[:id])
  end

  def edit
  end
end
