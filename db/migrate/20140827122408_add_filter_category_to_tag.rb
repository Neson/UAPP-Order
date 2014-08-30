class AddFilterCategoryToTag < ActiveRecord::Migration
  def change
    add_column :tags, :filter_category, :integer
  end
end
