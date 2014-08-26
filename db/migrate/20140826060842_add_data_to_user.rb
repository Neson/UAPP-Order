class AddDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :fbid, :string
    add_column :users, :student_id, :string
    add_column :users, :gender, :string
    add_column :users, :mobile_verified, :boolean
    add_column :users, :identity, :string
    add_column :users, :admission_department_code, :string
    add_column :users, :department_code, :string
    add_column :users, :admission_department, :string
    add_column :users, :department, :string
  end
end
