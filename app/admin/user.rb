ActiveAdmin.register User do
  menu priority: 9

  index do
    selectable_column
    id_column
    column :name do |user|
      link_to user.name, admin_user_path(user)
    end
    column :uid
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  form do |f|
    # f.inputs "User Details" do
    # end
    f.actions
  end
end
