ActiveAdmin.register Tag do
  menu priority: 70

  config.sort_order = "name_asc"

  permit_params :name, :filter_category

  index do
    selectable_column
    id_column
    column :name do |tag|
      link_to tag.name, admin_tag_path(tag)
    end
    column :filter_category
    actions
  end
end
