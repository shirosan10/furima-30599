class Order < ApplicationRecord
  belongs_to :user_id
  belongs_to :item_id
  has_one :address
end
