class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]
  
  def create
    bookComment = BookComment.new(book_comment_params)
    bookComment.user_id = current_user.id
    if bookComment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end


  def destroy
    bookComment = BookComment.find(params[:id])
    bookComment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:body,:book_id)
  end

  def ensure_correct_user  
    @bookComment = BookComment.find(params[:id])
    unless @bookComment.user == current_user
      redirect_to books_path
    end
  end
end
