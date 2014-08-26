class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :rate
      t.text :suggestion

      t.timestamps
    end
  end
end
