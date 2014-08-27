ActiveAdmin.register Admin do
  menu priority: 130
  permit_params :username, :email, :password, :password_confirmation, :locked_at

  index do
    selectable_column
    id_column
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
    f.inputs "Admin Details" do
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
      if params['admin'][:password].blank?
        params['admin'].delete("password")
        params['admin'].delete("password_confirmation")
      end
      super
    end
  end
end
