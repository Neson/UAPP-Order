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
