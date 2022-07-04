class FavoritesController < ApplicationController
  # いいねボタンが押された時に繋がるアクションを記述
  
  # postを見つけてそれに紐づいたfavoriteを生成したり削除したりできる設定
  def create
    @book = Book.find(params[:book_id])
    @favorite = current_user.favorite.new(book_id: params[:book_id])
    @favorite.save
    redirect_back(fallback_location: root_path) #いいねした前の画面に戻る
  end

  def destroy
    @book = Book.find(params[:book_id])
    @favorite = current_user.favorite.find_by(book_id: @book.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path) #いいねした前の画面に戻る
  end
end
