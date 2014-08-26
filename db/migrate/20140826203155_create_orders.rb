class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id, :null => false
      t.integer :product_id, :null => false
      t.float :price, :null => false
      t.integer :feedback_id

      t.timestamps
    end
  end
end
