Trestle.resource(:org_summery) do
  menu do
    item '部門/營業處每日回覆人數', icon: 'fas fa-virus'
  end

  search do |query|
    OrgSummery.all if query.nil?
    OrgSummery.joins(:organization).where('organizations.name ILIKE ?', "%#{query}%") if query.present?
  end

  (Date.today - 7.days..Date.today).reverse_each do |day|
    scope :"#{day.strftime('%m/%d')}", -> { OrgSummery.where(created_at: day.beginning_of_day..day.end_of_day) }
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :organization
    column :need_reports
    column :reported
    column :created_at, align: :center
    # actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |summery|
    row do
      col { number_field :need_reports }
      col { number_field :reported }
    end
    row do
      col { static_field :organization, summery.organization.name }
      col { static_field :created_at }
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
