class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :code
      t.string :name, :null => false

      t.timestamps
    end
  end
end
