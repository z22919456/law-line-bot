class DispatchController < ApplicationController
  def user_registration
    redirect_to edit_user_path
  end

  def daily
    return redirect_to edit_user_path, format: :html unless current_user.registered?
    return redirect_to user_org_summery_path if current_user.sales_supervisor?
    return redirect_to edit_user_daily_report_path if current_user.today_daily_report.present?

    redirect_to new_user_daily_report_path
  end

  def healthy_tracking
    return redirect_to edit_user_path unless current_user.registered?
    return redirect_to not_need_user_healthy_tracking_path unless current_user.need_tracking?
    return redirect_to edit_user_healthy_tracking_path if current_user.today_healthy_tracking.present?

    redirect_to new_user_healthy_tracking_path
  end

  def footprints; end

  def menu; end
end
