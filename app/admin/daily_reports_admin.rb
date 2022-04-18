Trestle.resource(:daily_reports) do
  menu do
    item '每日足跡回報', icon: 'fas fa-list-alt'
  end

  # scope :today, -> { DailyReport.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day) }
  # scope :yesterday, -> { DailyReport.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day) }
  # scope :manager, -> { User.manager }
  # scope :sales_supervisor, -> { User.sales_supervisor }

  (Date.today - 7.days..Date.today).reverse_each do |day|
    scope :"#{day.strftime('%m/%d')}", -> { DailyReport.where(created_at: day.beginning_of_day..day.end_of_day) }
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :user, link: true
    column :organization, link: true
    column :answered do |daily_report|
      I18n.t(daily_report.answered, scope: %i[activerecord attributes daily_report answers])
    end
    column :touch_date
    column :touch_location
    column :write do |daily_report|
      daily_report.eno.present? ? '部門負責人代填' : '本人填寫'
    end
    column :created_at, align: :center
    column :need_tracking_till, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |daily_report|
    static_field :answered, I18n.t(daily_report.answered, scope: %i[activerecord attributes daily_report answers])
    static_field :touch_date
    static_field :touch_location
    date_field :need_tracking_till
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:daily_report).permit(:name, ...)
  # end
end
