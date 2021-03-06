class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
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
    if @book.user_id != current_user.id  #@bookを持っているuserとログインしている人が等しい場合
      redirect_to books_path
    end
  end

  def update
    if @book.update(book_params)  
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy  #特にviewには渡さないため変数でok (@なし)
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
     unless @book.user == current_user
      redirect_to books_path
      # 他人の投稿詳細画面に行けなかったときの遷移先が一覧画面のパス
     end
  end
end
