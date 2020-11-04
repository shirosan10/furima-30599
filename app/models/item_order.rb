class ItemOrder < ApplicationRecord
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :postal_code, :prefecture_id, :city, :line, :building_room, :phone_number

  with_options presence: true do
    validates :token
    validates :postal_code,   format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :city
    validates :line
    validates :phone_number, format: { with: /\A[a-zA-Z0-9]+\z/ }
  end

  def save
    order = Order.create(user_id: user.id, item_id: item.id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, line: line, building_room: building_room, phone_number: phone_number, order_id: order.id)
  end
end
