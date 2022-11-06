class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
      @order_detail = OrderDetail.find(params[:id])
      @order_detail.update(order_detail_params)
      flash[:notice] = "制作ステータスを編集いたしました"
      redirect_to admin_order_path(@order_detail.order)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end