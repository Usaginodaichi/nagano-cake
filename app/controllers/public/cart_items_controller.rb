class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items =  current_customer.cart_items.all
    @total = 0
  end

  def create
    @item = Item.find(cart_item_params[:item_id])
    @cart_item = current_customer.cart_items.new(cart_item_params)
    # もし元々カート内に「同じ商品」がある場合、「数量を追加」更新・保存する
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      # 元々カート内にあるもの[item_id]
      # 現在追加した　params[:cart_item][:item_id]
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      # cart_item.amountに今追加したparams[:cart_item][:amount]を加える
      # to_iとして数字として扱う
      cart_item.save
      redirect_to public_cart_items_path
      # もしカート内に「同じ」商品がない場合は通常の保存処理
    elsif @cart_item.save
        @cart_items = current_customer.cart_items.all
        render :index
    else
        render :index
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    render :index
  end

  def destroy_all
    cart_items = CartItem.all
    cart_items.destroy_all
    render :index
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
