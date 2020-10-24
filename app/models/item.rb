class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre, :status, :shipping_fee, :prefecture,

  belongs_to :user
  has_one_attaced :image


  #空の投稿を保存できないようにする
  validates :title, :catch_copy, :genre_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_date_id, :price, presence: true

  #ジャンルの選択が「--」の時は保存できないようにする
  validates :genre_id, :status_id, :shipping_fee_id, :prefecture_id, numericality: { other_than: 0 } 


end
