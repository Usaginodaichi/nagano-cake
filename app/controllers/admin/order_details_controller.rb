class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
   @order = Order.find(params[:id])
   @order_details = @order_detail.order.all
   if @order_details.update
     flash[:notice] = "制作ステータスを編集いたしました"
     redirect_to admin_order_path
   else
     render :show
   end
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
