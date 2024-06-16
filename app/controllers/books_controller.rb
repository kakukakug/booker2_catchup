class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:update,:edit]

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @newBook = Book.new
    @newBook.score = 0

    @currentUserFavorite = Favorite.find_by(user_id: current_user.id, book_id:params[:id])

    @bookComments = BookComment.where(book_id:params[:id])

    @newBookComment = BookComment.new
  end

  def index
    case params[:sort]
      when "date" then
        @books = Book.all.order("created_at DESC")
      when "score" then
        @books = Book.all.order("score DESC")
      else
        @books = Book.all
      end
    
    @book = Book.new
    @book.score = 0

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body,:tag,:score)
  end

  def ensure_correct_user  
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
