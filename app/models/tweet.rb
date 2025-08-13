class Tweet < ApplicationRecord
     belongs_to :user   #追加
 
     has_one_attached :image

     has_many :likes, dependent: :destroy
     has_many :liked_users, through: :likes, source: :user

     #tweetsテーブルから中間テーブルに対する関連付け
     has_many :tweet_tag_relations, dependent: :destroy
     #tweetsテーブルから中間テーブルを介してTagsテーブルへの関連付け
     has_many :tags, through: :tweet_tag_relations, dependent: :destroy

def tier_label
  case likes.count
  when 10..Float::INFINITY then "Sランク"
  when 6..9 then "Aランク"
  when 3..5 then "Bランク"
  when 1..2 then "Cランク"
  else "pick up"
  end
end


end
