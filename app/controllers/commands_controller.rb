# 發送訊息取得回應
class CommandsController < ApplicationController
  include Kamigo::Clients::LineClient

  # 目前部門回報狀況
  def daily_report_summery
    return unless manager?

    @org = current_user.organization
  end

  # 代辦事項
  def todo_list
    @registered = current_user.registered?
    @daily_report = current_user.report_completed
    # @health_record =
  end

  def menu
    @registered = current_user.registered?
    @reported = current_user.daily_report.present?
    @need_tracking = current_user.need_tracking?
    @tracked = current_user.healthy_tracking.present?
  end

  private

  def manager?
    current_user.manager? || current_user.sales_supervisor?
  end
end
