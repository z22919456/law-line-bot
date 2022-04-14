class DispatchController < ApplicationController
  def user_registration
    redirect_to edit_user_path
  end

  def daily
    return redirect_to edit_user_path unless current_user.registered?
    return redirect_to user_org_summery_path if current_user.sales_supervisor?
    return redirect_to edit_user_daily_report_path if current_user.daily_reports.today.first

    redirect_to new_user_daily_report_path
  end

  def healthy_tracking
    return redirect_to edit_user_path unless current_user.registered?
  end

  def footprints; end

  def menu; end
end
