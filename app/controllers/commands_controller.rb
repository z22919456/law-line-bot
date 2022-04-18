# 發送訊息取得回應
class CommandsController < ApplicationController
  include Kamigo::Clients::LineClient

  # 目前部門回報狀況
  def daily_report_summery
    return if current_user.sales_supervisor? || current_user.manager?

    @org = current_user.organization
    @summery = @org.today_org_summery
    @org_daily_reports = @org.today_daily_reports.where.not(answered: 'normal')
  end

  # 我能做什麼？
  def menu
    @registered = current_user.registered?
    @reported = current_user.today_daily_report.present?
    @need_tracking = current_user.need_tracking?
    @tracked = current_user.today_healthy_tracking.present?
    @org = current_user.organization
  end

  # 今日確診者足跡

  def today_footprint
    @footprint = Footprint.today
  end

  private

  def manager?
    current_user.manager? || current_user.sales_supervisor?
  end
end
