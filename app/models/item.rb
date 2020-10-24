class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre

  belongs_to :user
  has_one_attaced :image

  validates :title,           presence: true
  validates :catch_copy,      presence: true
  validates :genre_id,        presence: true
  validates :status_id,       presence: true
  validates :shipping_fee_id, presence: true
  validates :prefecture_id,   presence: true
  validates :delivery_date_id,presence: true
  validates :price,           presence: true

  #空の投稿を保存できないようにする
  validates :title, :catch_copy, :genre_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_date_id, :price, presence: true

  #ジャンルの選択が「--」の時は保存できないようにする
  validates :genre_id, numericality: { other_than: 1 } 


end
