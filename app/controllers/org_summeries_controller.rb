class OrgSummeriesController < ApplicationController
  before_action :set_org_summery

  def new
    @org_summery = current_user.organization.org_summery.new
  end

  def edit; end

  def create
    @org_summery = current_user.organization.org_summery(org_summery_params)
  end

  def updated
    @org_summery.update(org_summery_params)
  end

  private

  def org_summery_params
    params.require(:org_summery).permit(:need_reports, :reported)
  end

  def set_org_summery
    @org_summery = params[:id] ? OrgSummery.find(params[:id]) : current_user.organization.org_summery.today.first
  end
end
