Trestle.resource(:healthy_trackings) do
  I18n.default_locale = :"zh-TW"
  menu do
    item '每日健康追蹤', icon: 'fas fa-virus'
  end

  Organization.where(id: HealthyTracking.joins(:user).pluck(:organization_id)).each do |organization|
    scope :"#{organization.name}", lambda {
                                     HealthyTracking.joins(:user).where(users: { organization_id: organization.id })
                                   }
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :user do |healthy_tracking|
      link_to healthy_tracking.user.real_name, edit_users_admin_path(healthy_tracking.user)
    end
    column :organization do |healthy_tracking|
      link_to healthy_tracking.organization.name, edit_organizations_admin_path(healthy_tracking.organization)
    end
    column :body_temperature
    column :foot_step
    column :health_feels_today
    column :health_feels_weeks
    column :created_at, align: :center
    # actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |_healthy_tracking|
    row do
      col { static_field :body_temperature }
      col { static_field :foot_step }
    end
    row do
      col { static_field :health_feels_today }
      col { static_field :health_feels_weeks }
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
  #   params.require(:healthy_tracking).permit(:name, ...)
  # end
end
