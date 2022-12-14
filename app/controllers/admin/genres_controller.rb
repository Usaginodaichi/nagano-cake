class Admin::GenresController < ApplicationController
  # before_action :authenticate_admin!
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルの登録が完了しました"
      redirect_to admin_genres_path(@genre.id)
    else
      flash[:notice] = "ジャンルの名前を入力してください"
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
   @genre = Genre.find(params[:id])
   if @genre.update(genre_params)
     flash[:notice] = 'ジャンルの変更が完了しました'
     redirect_to admin_genres_path(@genre.id)
   else
     render :edit
   end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
