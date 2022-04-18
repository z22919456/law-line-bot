Trestle.resource(:users) do
  menu do
    item '公司同仁', icon: 'fa fa-user'
  end

  search do |query|
    User.all if query.nil?
    if query.present?
      User.where('name ILIKE ? OR real_name ILIKE ? OR eno LIKE ?', "%#{query}%", "%#{query}%",
                 "%#{query.upcase}%")
    end
  end

  scope :sales, -> { User.sales }
  scope :staff, -> { User.staff }
  scope :manager, -> { User.manager }
  scope :sales_supervisor, -> { User.sales_supervisor }

  # Customize the table columns shown on the index view.
  #
  table do
    column :image_url do |user|
      image_tag(user.image_url, style: 'height: 50px') if user.image_url
    end
    column :name
    column :real_name
    column :eno
    column :organization
    column :role do |user|
      I18n.t(user.role, scope: %i[activerecord attributes user roles])
    end
    column :need_track do |user|
      user.need_tracking? ? '是' : '否'
    end
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |user|
    tab :user do
      text_field :name
      collection_select :organization_id, Organization.all, :id, :name
      select :role, User.roles.keys.map { |k| [I18n.t(k, scope: %i[activerecord attributes user roles]), k] }
      row do
        col { datetime_field :updated_at }
        col { datetime_field :created_at }
      end
    end

    tab :daily_report, badge: user.daily_reports.count do
      table DailyReportsAdmin.table, collection: user.daily_reports
    end

    tab :healthy_tracking, badge: user.healthy_trackings.count do
    end

    if user.sales_supervisor?
      tab :org_daily_reports, badge: user.daily_reports.count do
      end
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
  #   params.require(:user).permit(:name, ...)
  # end
end
