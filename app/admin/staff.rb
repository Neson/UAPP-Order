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

  show do |staff|
    attributes_table do
      row :id
      row :username
      row :email
    end
    panel "#{staff.username} 確認的款項" do
      table_for(staff.actions.payment_confirmeds) do |action|
        column '操作時間' do |action|
          action.created_at
        end
        column '操作訂單' do |action|
          "#{auto_link action.order} (#{action.order.product.name}, NT$#{action.order.price})".html_safe
        end
        column '操作工作人員' do |action|
          auto_link action.staff
        end
        column '動作' do |action|
          status_tag(action.action, :class => action.action)
        end
        column '操作後訂單狀態' do |action|
          status_tag(action.state, :class => action.state)
        end
      end
    end
    panel "#{staff.username} 收取的款項" do
      total = 0.0
      table_for(staff.actions.payment_receiveds) do |action|
        column '操作時間' do |action|
          action.created_at
        end
        column '操作訂單' do |action|
          "#{auto_link action.order} (#{action.order.product.name}, NT$#{action.order.price})".html_safe
        end
        column '金額' do |action|
          total += action.order.price
          "NT$ #{action.order.price}".html_safe
        end
        column '操作工作人員' do |action|
          auto_link action.staff
        end
        column '動作' do |action|
          status_tag(action.action, :class => action.action)
        end
        column '操作後訂單狀態' do |action|
          status_tag(action.state, :class => action.state)
        end
      end
      div "總共收取：NT$ #{total}"
    end
    panel "#{staff.username} 發送的商品" do
      total = 0
      table_for(staff.actions.delivereds) do |action|
        column '操作時間' do |action|
          total += 1
          action.created_at
        end
        column '操作訂單' do |action|
          "#{auto_link action.order} (#{action.order.product.name}, NT$#{action.order.price})".html_safe
        end
        column '操作工作人員' do |action|
          auto_link action.staff
        end
        column '動作' do |action|
          status_tag(action.action, :class => action.action)
        end
        column '操作後訂單狀態' do |action|
          status_tag(action.state, :class => action.state)
        end
      end
      div "總共送了 #{total} 個產品"
    end
    panel "#{staff.username} 回報的客服問題" do
      total = 0
      table_for(staff.actions.issues) do |action|
        column '操作時間' do |action|
          total += 1
          action.created_at
        end
        column '操作訂單' do |action|
          "#{auto_link action.order} (#{action.order.product.name}, NT$#{action.order.price})".html_safe
        end
        column '操作工作人員' do |action|
          auto_link action.staff
        end
        column '動作' do |action|
          status_tag(action.action, :class => action.action)
        end
        column '操作後訂單狀態' do |action|
          status_tag(action.state, :class => action.state)
        end
      end
      div "總共報告了 #{total} 個問題"
    end
    active_admin_comments
  end

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
