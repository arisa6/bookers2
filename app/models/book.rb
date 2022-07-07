class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  
  # 引数で渡されたbook idがFavoritesテーブル内に存在（exists?）するかどうかを調べる
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"  #完全一致
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"  #前方一致
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"  #後方一致
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"  #部分一致
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
  
  #whereメソッドを使いデータベースから該当データを取得し、変数に代入する
end
