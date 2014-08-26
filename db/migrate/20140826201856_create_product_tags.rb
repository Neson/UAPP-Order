class CreateProductTags < ActiveRecord::Migration
  def change
    create_table :product_tags do |t|
      t.integer :product_id, :null => false
      t.integer :tag_id, :null => false

      t.timestamps
    end
  end
end
