class AddCustomColumnsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :custom_column_1, :string
    add_column :orders, :custom_column_2, :string
  end
end
