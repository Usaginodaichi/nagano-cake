class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

 def index
   @genre = Genre.new
   @genres = Genre.all
 end

  def create
   @genre = Genre.new(genre_params)
   redirect_to admin_genres
  end

  def edit
  end
end
