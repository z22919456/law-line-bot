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
      # 若非填寫否 則需要補充其他資料
      return render :next_step unless @daily_report.completed?

      render action: :index
    else
      render :new
    end
  end

  def edit
    redirect_to action: :new if @daily_report.nil?
  end

  def next_step; end

  def update
    # 確認是否更新第二步驟 若是 則驗證第二步驟的填寫資訊
    if params.dig(:daily_report, :second)
      unless daily_report_params[:touch_date].present?
        @daily_report.errors.add(:touch_date,
                                 '請回覆您足跡重疊/被通知需要自主健康管理的開始時間')
      end
      unless daily_report_params[:touch_location].present?
        @daily_report.errors.add(:touch_location,
                                 '請回覆足跡重疊地點或需要自主健康管理的原因')
      end
    end

    return render :next_step unless @daily_report.errors.empty?

    # 開始更新資訊
    if @daily_report.update(daily_report_params)
      return render :next_step unless @daily_report.completed?

      redirect_to action: :index
    else
      return render :next_step if params[:daily_report][:second]

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
    @daily_report = current_user.daily_reports.today.first
  end
end
