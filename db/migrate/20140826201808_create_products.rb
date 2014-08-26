class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :code
      t.string :name, :null => false
      t.integer :provider_id
      t.text :description
      t.text :specification
      t.string :image
      t.float :original_price
      t.float :price, :null => false

      t.timestamps
    end
  end
end
