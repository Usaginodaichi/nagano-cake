class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    @order_detail = @order.order_details.find(params[:id])
    @order.update(order_params)
    flash[:notice] = "注文ステータスを変更いたしました"
    redirect_to admin_order_path
  end


  private
  def order_params
    params.require(:order).permit(:status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
