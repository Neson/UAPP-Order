ActiveAdmin.register Order do
  menu priority: 10

  filter :created_at, :label => '訂購日期'
  filter :user, :label => '訂購者'
  filter :product, :label => '訂購項目'
  filter :state, :label => '訂單狀態'
  filter :price, :label => '價格'
  filter :custom_column_1, :label => '自定欄位一'
  filter :custom_column_2, :label => '自定欄位二'

  index do
    selectable_column
    # id_column
    column '訂單', :sortable => :id do |o|
      link_to "##{o.id} ", admin_order_path(o)
    end
    column '訂購日期', :sortable => :created_at do |o|
      o.created_at
    end
    column '訂購者', :sortable => :user_id do |o|
      auto_link o.user
    end
    column '訂購項目', :sortable => :product_id do |o|
      auto_link o.product
    end
    column '產品代碼', :sortable => :product_id do |o|
      o.product.code
    end
    column '自定欄位一', :sortable => :product_id do |o|
      o.custom_column_1
    end
    column '自定欄位二', :sortable => :product_id do |o|
      o.custom_column_2
    end
    column '訂單狀態' do |o|
      status_tag(o.state, :class => o.state)
    end
    column '付款通知' do |o|
      auto_link o.payment_report
    end
    column '金額' do |o|
      number_to_currency o.price
    end
    actions
  end


  show do |o|
    attributes_table do
      row :id
      row :user
      row :product
      row :state
      row :price
      row :payment_report
      row :created_at
      row :updated_at
      row :custom_column_1
      row :custom_column_2
    end
    panel "歷史狀態" do
      table_for(o.states.order('created_at desc')) do |s|
        column '更新時間' do |s|
          s.created_at
        end
        column '操作使用者' do |s|
          auto_link s.user
        end
        column '操作工作人員' do |s|
          auto_link s.staff
        end
        column '動作' do |s|
          status_tag(s.action, :class => s.action)
        end
        column '狀態' do |s|
          status_tag(s.state, :class => s.state)
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs '訂單無法直接編輯，您只能刪除它 (小心)，或用 Staff 帳號登入來變更狀態。' do
    end
    f.actions
  end
end
