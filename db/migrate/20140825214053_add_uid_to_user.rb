class AddUidToUser < ActiveRecord::Migration
  def change
    add_column :users, :uid, :integer, :null => false
  end
end