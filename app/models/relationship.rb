class Relationship < ApplicationRecord
    
    belongs_to :follower, class_name: "User"   
    belongs_to :followed, class_name: "User" 
    
    
    #正しくusersテーブルを参照する
    #belongs_to :userとするとどっちがどっちのuserかわからなくなるため、followerとfollowedで分ける。
    #class_name: "User"でuserテーブルからデータをとってきてもらう
    
end
