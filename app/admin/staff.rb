ActiveAdmin.register Staff do
  menu priority: 110
  permit_params :username, :email, :password, :password_confirmation, :locked_at

  index do
    selectable_column
    id_column
    column :username do |staff|
      link_to staff.username, admin_staff_path(staff)
    end
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Staff Details" do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :locked_at
    end
    f.actions
  end

  controller do

    def update
      if params['staff'][:password].blank?
        params['staff'].delete("password")
        params['staff'].delete("password_confirmation")
      end
      super
    end
  end
end
