class CreateMarkets < ActiveRecord::Migration[5.2]
  def change
    create_table :markets do |t|
      t.string :name
      t.string :base_currency
      t.string :quote_currency
      t.string :minimum_order_amount
      t.float :taker_fee
      t.float :maker_fee
      t.integer :max_orders_per_minute
      t.float :maker_discount_percentage
      t.float :taker_discount_percentage

      t.timestamps
    end
  end
end
