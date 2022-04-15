class DailyReportsController < ApplicationController
  before_action :authenticate_user
  before_action :set_daily_report, only: %i[edit update new]
  before_action :check_redirect, only: %i[new]

  def new
    @daily_report = current_user.daily_reports.new
  end

  def create
    @daily_report = current_user.daily_reports.create(daily_report_params)
    if @daily_report.errors.empty?
      redirect_to action: :show
    else
      render :new
    end
  end

  def edit
    redirect_to action: :new if @daily_report.nil?
  end

  def update
    if @daily_report.update(daily_report_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  private

  def check_redirect
    path = edit_user_daily_report_path if @daily_report.present?
    path = new_user_org_daily_report_path if current_user.sales_supervisor?
    return if path.nil?

    redirect_to path, size: :full
  end

  def daily_report_params
    params.require(:daily_report).permit(:answered, :user_id, :touch_date, :touch_location)
  end

  def set_daily_report
    @daily_report = current_user.today_daily_report
  end
end
