class CreateShippingFeeSkipMigrations < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_fee__skip_migrations do |t|

      t.timestamps
    end
  end
end
