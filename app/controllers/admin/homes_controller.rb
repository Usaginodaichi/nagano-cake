class Admin::HomesController < ApplicationController
  def top
  end

  def index
    @order = Order.all
  end
end
