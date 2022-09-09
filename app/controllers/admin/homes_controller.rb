class Admin::HomesController < ApplicationController
    before_action :authenticate_admin!

  def top
    # @orders = Customer.all 会員idから引っ張る　現在未設定
  end

end
