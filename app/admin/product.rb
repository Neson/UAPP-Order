ActiveAdmin.register Product do
  menu priority: 50

  permit_params :code, :name, :description, :specification, :image, :original_price, :price, :hide_price, :provider_id, product_tags_attributes: [:product_id, :tag_id]

  config.sort_order = "code_asc"

  index do
    selectable_column
    id_column
    column :provider
    column :code
    column :name
    column :description
    column :price
    column :tags do |p|
      p.tags.map { |t| t.name }.join ', '
    end
    actions
  end

  show do |p|
    attributes_table do
      row :id
      row :provider
      row :code
      row :name do |product|
        link_to product.name, admin_product_path(product)
      end
      row :description
      row :specification
      row :original_price
      row :price
      row :hide_price
      row :tags do |p|
        p.tags.map { |t| t.name }.join ', '
      end
      row :image do
        image_tag(p.image)
      end
    end
    panel "#{product.name} 的訂單" do
      table_for(product.orders) do |o|
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
      end
    end
    active_admin_comments
  end

  form :partial => "form"

  csv :force_quotes => true do
    column("Provider name") { |product| product.provider.name }
    column("Provider code") { |product| product.provider.code }
    column("Code") { |product| product.code }
    column("Name") { |product| product.name }
    column("Description") { |product| product.description }
    column("Specification") { |product| product.specification }
    column("Image") { |product| product.image }
    column("Original price") { |product| product.original_price }
    column("Price") { |product| product.price }
    column("Hide price") { |product| product.hide_price }
    column("Tag names") { |product| product.tags.map{ |tag| tag.name }.join(',') }
  end

  # Hack: 用 validate 來填入資料，然後在建 tag_names 的時候 save
  active_admin_import :validate => true,
    :template_object => ActiveAdminImport::Model.new(
      :hint => "匯入 CSV 檔案。匯入成功後可能會顯示錯誤訊息，請直接到產品頁面檢查是否匯入成功，若失敗可能是格式不正確或資料重複！"
    ),
    :after_import => proc{

    }

  controller do

    def update
      super
      if !!params[:tags]
        @product.product_tags.destroy_all
        params[:tags].each do |tag_id|
          @product.product_tags.create({:tag_id => tag_id.to_i})
        end
      end
    end

    def create
      super
      if !!params[:tags]
        @product.product_tags.destroy_all
        params[:tags].each do |tag_id|
          @product.product_tags.create({:tag_id => tag_id.to_i})
        end
      end
    end
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
