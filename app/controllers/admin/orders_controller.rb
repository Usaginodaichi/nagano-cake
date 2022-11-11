class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    if @order.update(order_params)
      if @order.status == "confirmation"
       @order_details.update_all(making_status:1)
      end
      flash[:notice] = "注文ステータスを変更いたしました"
      redirect_to admin_order_path(@order)
    end
  end


  private
  def order_params
    params.require(:order).permit(:status)
  end
end
