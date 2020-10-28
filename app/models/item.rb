class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_date

  belongs_to :user
  has_one_attached :image


  #空の投稿を保存できないようにする
  validates :title, :catch_copy, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_date_id, :price, presence: true

  #ジャンルの選択が「--」の時は保存できないようにする
  validates :category_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_date, numericality: { other_than: 0 }


end
