class CreateItemOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :item_orders do |t|
      t.string  :postal_code,    default: "",  null: false
      t.integer :prefecture_id,                null: false
      t.string  :city,           default: "",  null: false
      t.string  :line,   default: "",  null: false
      t.string  :building_room,  default: ""
      t.string :phone_number,                  null: false
      t.integer :order_id,                     null: false,  foreign_key: true

      t.timestamps
    end
  end
end
