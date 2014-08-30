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

  show do |user|
    attributes_table do
      row :name
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
      row :fbid do
        link_to user.fbid, "https://facebook.com/#{user.fbid}"
      end
      row :student_id
      row :gender
      row :department
    end
    panel "#{user.name} 的訂單" do
      table_for(user.orders) do |o|
        column '訂單', :sortable => :id do |o|
          link_to "##{o.id} ", admin_order_path(o)
        end
        column '訂購日期', :sortable => :created_at do |o|
          o.created_at
        end
        # column '訂購者', :sortable => :user_id do |o|
        #   auto_link o.user
        # end
        column '訂購項目', :sortable => :product_id do |o|
          auto_link o.product
        end
        column '產品代碼', :sortable => :product_id do |o|
          o.product.code
        end
        column '訂單狀態' do |o|
          status_tag(o.state, :class => o.state)
        end
        column '金額' do |o|
          number_to_currency o.price
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs '使用者資料係由使用者認證系統提供，無法直接編輯，您只能刪除它 (小心)。' do
    end
    f.actions
  end
end
