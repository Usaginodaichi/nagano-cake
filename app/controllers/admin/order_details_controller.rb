class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
      @order_detail = OrderDetail.find(params[:id])
      @order = @order_detail.order
      if @order_detail.update(order_detail_params)
        if @order_detail.making_status = "production"
          @order.update(status:2)
        end
      flash[:notice] = "制作ステータスを編集いたしました"
      redirect_to admin_order_path(@order_detail.order)
      end
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
