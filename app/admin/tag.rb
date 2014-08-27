ActiveAdmin.register Tag do
  menu priority: 70

  config.sort_order = "name_asc"

  permit_params :name

  index do
    selectable_column
    id_column
    column :name do |tag|
      link_to tag.name, admin_tag_path(tag)
    end
    actions
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
