class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  private
  def item_params
    params.permit(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end



end
