class AddDataUpdateTimeToUser < ActiveRecord::Migration
  def change
    add_column :users, :data_update_time, :datetime
  end
end
