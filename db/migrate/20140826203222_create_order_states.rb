class CreateOrderStates < ActiveRecord::Migration
  def change
    create_table :order_states do |t|
      t.integer :order_id, :null => false
      t.integer :user_id
      t.integer :staff_id
      t.string :action, :null => false
      t.string :state, :null => false

      t.timestamps
    end
  end
end
