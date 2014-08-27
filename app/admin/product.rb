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

  form do |f|
    f.inputs "Details" do
      f.input :provider
      f.input :code
      f.input :name
      f.input :description
      f.input :specification
      f.input :image
      f.input :original_price
      f.input :price
    end

    f.has_many :product_tags do |tag_f|
      # tag_f.inputs "Tag" do
        tag_f.input :tag, input_html: {class: 'select2Able'} # it should automatically generate a drop-down select to choose from your existing tags

        if !tag_f.object.nil?
          # show the destroy checkbox only if it is an existing tag
          # else, there's already dynamic JS to add / remove new tags
          tag_f.input :_destroy, :as => :boolean, :label => "刪除"
        end
      # end
    end

    f.actions
  end

  controller do

    def update
      # params[:product][:product_tags_attributes].each do |k,v|
      #   Product.find(params[:id]).product_tags.find_by_tag_id(v['tag_id']).destroy! if v['_destroy'].to_i == 1
      # end
      if !!params[:product][:product_tags_attributes] && !!params[:product][:product_tags_attributes]['0']
        Product.find(params[:id]).product_tags.destroy_all
      end
      params[:product][:product_tags_attributes].reject! do |k,v|
        # !!Product.find(params[:id]).tags.find_by_id(v['tag_id']) || v['_destroy'].to_i == 1
        v['_destroy'].to_i == 1
      end
      tags = []
      params[:product][:product_tags_attributes].reject! do |k,v|
        t = tags.include?(v['tag_id'])
        tags << v['tag_id']
        t
      end
      super
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
