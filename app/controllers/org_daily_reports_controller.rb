class OrgDailyReportsController < ApplicationController
  before_action :set_daily_report, only: %i[edit destroy update]
  before_action :validates, only: %i[update create]
  def index
    @org = current_user.organization
    @org_summery = @org.org_summeries.today.first
    @daily_reports = @org.daily_reports
  end

  def new
    @daily_report = current_user.organization.daily_reports.new
  end

  def create
    if @daily_report.errors.empty? && @daily_report.update(daily_report_params)
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit; end

  def update
    @daily_report = @daily_report.update(daily_report_params)
    if @daily_report.errors.empty?
      redirect_to action: :index
    else
      render :new
    end
  end

  def destroy
    if @daily_report.destroy
      flash[:success] = '刪除成功'
    else
      flash[:alert] = '刪除失敗'
    end
    redirect_to action: :index
  end

  private

  def validates
    @daily_report = current_user.organization.daily_reports.new unless @daily_report.present?
    @daily_report.errors.add(:eno, '此為必填欄位') unless daily_report_params[:eno].present?
    @daily_report.errors.add(:touch_date, '此為必填欄位') unless daily_report_params[:touch_date].present?
    @daily_report.errors.add(:touch_location, '此為必填欄位') unless daily_report_params[:touch_location].present?
    @daily_report.errors.add(:answered, '請選擇一個選項') unless daily_report_params[:answered].present?
  end

  def daily_report_params
    params.require(:daily_report).permit(:answered, :touch_date, :touch_location, :eno)
  end

  def set_daily_report
    @org = current_user.organization
    @daily_report = @org.daily_reports.find(params[:id])
  end
end
