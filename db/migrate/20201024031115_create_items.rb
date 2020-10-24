class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|

      t.references :user,                null: false, foreign_key: true
      t.string  :title,                  null: false
      t.text    :catch_copy,             null: false
      t.integer :genre_id,               null: false
      t.integer :status_id,              null: false
      t.integer :shipping_fee_id,        null: false
      t.integer :prefecture_id,          null: false
      t.integer :delivery_date_id,       null: false
      t.integer :price,                  null: false
      t.timestamps
    end
  end
end
