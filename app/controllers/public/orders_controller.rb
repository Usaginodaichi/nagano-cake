class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @total = 0
    @cart_items = current_customer.cart_items.all
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else
      @address = current_customer.addresses.new(address_params)
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
  end

  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = CartItem.all
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.item_id = cart_item.item_id
      @order_details.order_id = @order.id
      @order_details.amount = cart_item.amount
      @order_details.price = cart_item.amount * cart_item.item.price
      @order_details.save
    end
    redirect_to complete_public_orders_path
    @cart_items.destroy_all
  end


  def complete
  end

  def index
    @orders = Order.all
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment)
  end

  def address_params
    params.require(:order).permit(:name, :postal_code, :address)
  end

  # def order_detail_params
  #   params.require(:order_detail).permit(:order_id, :item_id, :price, :amount)
  # end
end
