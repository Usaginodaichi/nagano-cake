class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    flash[:notice] = "注文ステータスを変更いたしました"
    redirect_to admin_order_path(@order)
  end


  private
  def order_params
    params.require(:order).permit(:status)
  end
end
