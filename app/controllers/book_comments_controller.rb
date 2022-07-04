class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.book_id = current_user.id
    if @book_comment.save
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @book_comment = Book.find(params[:book_id])
    @book_comment = bookcomment.find_by(params[:id])
    @book_comment.destroy
    redirect_back(fallback_location: root_path)
    
  end
end
