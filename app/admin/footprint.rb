ActiveAdmin.register Footprint do
  permit_params :pdf_url, :note

  index do
    selectable_column
    id_column
    column :pdf_url
    column :note
    actions
  end

  form do |f|
    f.inputs do
      f.input :pdf_url
      f.input :note
    end
    f.actions
  end
end
