ActiveAdmin.register Order do
  menu priority: 10

  filter :created_at, :label => '訂購日期'
  filter :user, :label => '訂購者'
  filter :product, :label => '訂購項目'
  filter :state, :label => '訂單狀態'
  filter :price, :label => '價格'

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
    column '訂單狀態' do |o|
      status_tag(o.state, :class => o.state)
    end
    column '金額' do |o|
      number_to_currency o.price
    end
    actions
  end

  show do |user|
    attributes_table do
      row :title
      row :image do
        image_tag(ad.image.url)
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
