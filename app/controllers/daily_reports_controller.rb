class DailyReportsController < ApplicationController
  before_action :set_daily_report
  def new
    return render edit(@daily_report) if @daily_report.present?

    @daily_report = current_user.daily_reports.new
  end

  def create
    if current_user.daily_reports.create(daily_report_params)
      render :index
    else
      render :create, formats: :liff
    end
  end

  def edit; end

  private

  def daily_report_params
    params.require(:daily_report).permit(:answered, :user_id)
  end

  def set_daily_report
    @daily_report = current_user.daily_reports.today
  end
end
