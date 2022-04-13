class OrgDailyReportsController < ApplicationController
  before_action :set_daily_report, only: :edit
  def index
    @daily_reports = current_user.organization.daily_reports
  end

  def new
    @daily_report = current_user.organization.daily_reports.new
  end

  def create
    @daily_report = current_user.organization.daily_reports.create(daily_report_params)
    if @daily_report.errors.empty?
      render :index
    else
      render :new
    end
  end

  def edit; end

  def update
    @daily_report = current_user.daily_reports.create(daily_report_params)
    if @daily_report.errors.empty?
      render :index
    else
      render :new
    end
  end

  private

  def daily_report_params
    params.require(:daily_report).permit(:answered, :user_id, :touch_date, :touch_location, :eno)
  end

  def set_daily_report
    @daily_report = DailyReport.find(params[:id])
  end
end
