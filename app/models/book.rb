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
  def self.search_for(content, method)
    if method == "perfect"  #完全一致
       Book.where("title: content")
    elsif method == "forward"  #前方一致
       Book.where("title LIKE?", content+"%")
    elsif method == "backward"  #後方一致
       Book.where("title LIKE?", "%"+content)
    elsif  #部分一致
       Book.where("title LIKE?", "%"+content+"%")
    end
  end
  
  #whereメソッドを使いデータベースから該当データを取得し、変数に代入する
end
