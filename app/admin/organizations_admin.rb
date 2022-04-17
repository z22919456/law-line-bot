Trestle.resource(:organizations) do
  menu do
    item :organizations, icon: 'fas fa-building'
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :name
    column :users do |organization|
      organization.users.size
    end
    column :is_sales, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |organization|
    tab :organization do
      row do
        col { text_field :name }
        col { check_box :is_sales }
      end
    end

    tab :users, badge: organization.users.size do
      table UsersAdmin.table, collection: organization.users
    end

    tab :supervisors, badge: organization.users.sales_supervisor.size do
      table UsersAdmin.table, collection: organization.users.sales_supervisor
    end
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:organization).permit(:name, ...)
  # end
end
