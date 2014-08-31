ActiveAdmin.register PaymentReport do
  menu priority: 11

  index do
    selectable_column
    # id_column
    column '付款通知', :sortable => :id do |pr|
      link_to "##{pr.id} ", admin_payment_report_path(pr)
    end
    column '建立日期', :sortable => :created_at do |pr|
      pr.created_at
    end
    column '付款帳號', :sortable => :account_number do |pr|
      pr.account_number
    end
    column '付款時間', :sortable => :datetime do |pr|
      pr.datetime
    end
    column '已確認' do |pr|
      if pr.confirmed
        status_tag('yes', :class => 'yes')
      else
        status_tag('no', :class => 'no')
      end
    end
    column '確認人員', :sortable => :confirm_staff_id do |pr|
      auto_link pr.confirm_staff
    end
    column '金額' do |pr|
      number_to_currency pr.amout
    end
    actions
  end


  show do |pr|
    attributes_table do
      row :id
      row :account_number
      row :datetime
      row :amout
      row :created_at
      row :updated_at
      row :confirmed
      row :confirm_staff
    end
    panel "訂單" do
      table_for(pr.orders) do |o|
        column '訂單' do |o|
          link_to "##{o.id} ", admin_order_path(o)
        end
        column '訂購日期' do |o|
          o.created_at
        end
        column '訂購者' do |o|
          auto_link o.user
        end
        column '訂購項目' do |o|
          auto_link o.product
        end
        column '產品代碼' do |o|
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
    f.inputs '訂單無法直接編輯，您只能刪除它 (小心)，或用 Staff 帳號登入來變更狀態。' do
    end
    f.actions
  end
end
