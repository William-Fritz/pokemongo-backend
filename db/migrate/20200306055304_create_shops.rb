class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :item_name
      t.integer :sell_price
      t.integer :buy_price

      t.timestamps
    end
  end
end
