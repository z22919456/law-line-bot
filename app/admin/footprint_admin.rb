Trestle.resource(:footprint) do
  menu do
    item :footprint, icon: 'fas fa-paw'
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :pdf_url do |footprint|
      link_to footprint.pdf_url, footprint.pdf_url
    end
    column :note
    column :created_at, align: :center
    # actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |_healthy_tracking|
    text_field :pdf_url
    text_area :note
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:healthy_tracking).permit(:name, ...)
  # end
end
