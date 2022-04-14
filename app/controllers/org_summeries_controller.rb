class OrgSummeriesController < ApplicationController
  before_action :set_org_summery
  before_action :check_redirect, only: %i[new]

  def new
    @org_summery = current_user.organization.org_summeries.new
  end

  def edit
    redirect_to action: :new if @org_summery.nil?
  end

  def create
    @org_summery = current_user.organization.org_summeries.create(org_summery_params)
    if @org_summery.errors.empty?
      redirect_to user_org_daily_reports_path
    else
      render :new
    end
  end

  def update
    @org_summery.update(org_summery_params)
    if @org_summery.errors.empty?
      redirect_to user_org_daily_reports_path
    else
      render :edit
    end
  end

  private

  def check_redirect
    path = edit_user_org_summery_path if @org_summery.present?
    return if path.nil?

    redirect_to path, size: :full
  end

  def org_summery_params
    params.require(:org_summery).permit(:need_reports, :reported)
  end

  def set_org_summery
    @org_summery = current_user.organization.org_summeries.today.first
  end
end
