class AddHidePriceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :hide_price, :boolean, :null => false, :default => false
  end
end
