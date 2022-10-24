class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items =  current_customer.cart_items.all
    @total = 0
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.amount = params[:cart_item][:id]
    cart_item.update(cart_item_params)
    flash[:notice] = "個数を変更しました"
    redirect_to public_cart_items_path
  end

  def create
    # @item = Item.find(cart_item_params[:item_id])
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
      flash[:success] = "カートに商品を追加しました"
      redirect_to public_cart_items_path
      # もしカート内に「同じ」商品がない場合は通常の保存処理
    elsif @cart_item.save
        @cart_items = current_customer.cart_items.all
        flash[:success] = "カートに商品を追加しました"
        redirect_to public_cart_items_path
    else
      flash[:danger] = "個数を入力してください"
      render :index
    end

  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    flash[:notice] = "カートから削除されました"
    redirect_to public_cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    flash[:notice] = "カートが空になりました"
    redirect_to public_cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
