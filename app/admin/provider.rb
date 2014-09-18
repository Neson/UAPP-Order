ActiveAdmin.register Provider do
  menu priority: 60

  permit_params :code, :name

  config.sort_order = "code_asc"

  index do
    selectable_column
    id_column
    column :code
    column :name do |provider|
      link_to provider.name, admin_provider_path(provider)
    end
    actions
  end

  show do |provider|
    attributes_table do
      row :id
      row :code
      row :name
    end
    panel "#{provider.name} 的訂單" do
      table_for(provider.products) do |p|
        column '產品', :sortable => :product_id do |p|
          auto_link p
        end
        column '全部訂單數量' do |p|
          p.orders.count
        end
        column '已確認付款、未交貨訂單數量' do |p|
          p.orders.where('state = ?', 'paid').count
        end
      end
    end
    active_admin_comments
  end

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end


end
