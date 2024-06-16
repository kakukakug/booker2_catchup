class FavoritesController < ApplicationController
  def create
    favorite = Favorite.new()
    favorite.user_id = current_user.id
    favorite.book_id = params[:book_id]
    if favorite.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
