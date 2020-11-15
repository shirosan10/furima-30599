class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_date

  belongs_to :user
  has_one :order
  has_one_attached :image
  has_many :comments

  # 空の投稿を保存できないようにする
  with_options presence: true do
    validates :image
    validates :title
    validates :catch_copy
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :delivery_date_id
    validates :price, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters.' }
  end

  # ジャンルの選択が「--」の時は保存できないようにする
  validates :category_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_date_id, numericality: { other_than: 0, message: 'Select' }

  # 金額範囲のバリデーション
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }
end
