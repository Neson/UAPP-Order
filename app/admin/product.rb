ActiveAdmin.register Product do
  menu priority: 50

  permit_params :code, :name, :description, :specification, :image, :original_price, :price, :provider, :provider_id, product_tags_attributes: [:product_id, :tag_id]

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
      row :name
      row :description
      row :specification
      row :original_price
      row :price
      row :tags do |p|
        p.tags.map { |t| t.name }.join ', '
      end
      row :image do
        image_tag(p.image)
      end
    end
    active_admin_comments
  end

  form :partial => "form"

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
