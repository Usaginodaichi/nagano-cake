class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def confirm
    @total = 0
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
      @order.status = 0
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
      @order.status = 0
    elsif params[:order][:select_address] =="2"
      @address = Address.new(address_params)
      @address.customer_id = current_customer.id
      if @address.save
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
        @order.status = 0
      else
        @total = 0
        @cart_items = current_customer.cart_items.all
        @order = Order.new(order_params)
        render :confirm
      end
    else
      @total = 0
      @cart_items = current_customer.cart_items.all
      @order = Order.new(order_params)
      render :confirm
    end
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.save
      @cart_items.each do |cart_item|
        @order_details = OrderDetail.new
        @order_details.order_id = @order.id
        @order_details.item = cart_item.item
        @order_details.amount = cart_item.amount
        @order_details.price = cart_item.amount * cart_item.item.price
        @order_details.save
      end
      @cart_items.destroy_all
      redirect_to complete_public_orders_path
  end


  def complete
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :status, :total_payment)
  end

  def address_params
    params.permit(:name, :postal_code, :address)
  end

  # def order_detail_params
  #   params.require(:order_detail).permit(:order_id, :item_id, :price, :amount)
  # end
end
