class FavoritesController < ApplicationController
  # いいねボタンが押された時に繋がるアクションを記述
  
  # postを見つけてそれに紐づいたfavoriteを生成したり削除したりできる設定
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    #redirect_to request.referer (非同期通信化)  #いいねした前の画面に戻る
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    #redirect_to request.referer (非同期通信化)  #いいねした前の画面に戻る
  end
end
