class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flacsh[:notice] = "商品の登録が完了しました"
      redirect_to admin_items
    else
      render :new
    end
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.permit(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end



end
