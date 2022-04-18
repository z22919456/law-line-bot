class OrgSummeriesController < ApplicationController
  before_action :authenticate_user
  before_action :set_org_summery
  before_action :check_role

  def show
    @daily_reports = @org.daily_reports
    render :show
  end

  def new
    redirect_to edit_user_org_summery_path if @org_summery.present?

    @org_summery = @org.org_summeries.new
  end

  def edit
    redirect_to action: :new if @org_summery.nil?
  end

  def create
    @org_summery = @org.org_summeries.create(org_summery_params)
    if @org_summery.errors.empty?
      redirect_to action: :show
    else
      render :new
    end
  end

  def update
    @org_summery.update(org_summery_params)
    if @org_summery.errors.empty?
      redirect_to action: :show
    else
      render :edit
    end
  end

  private

  def check_role
    redirect_to new_user_daily_report_path unless current_user.sales_supervisor?
  end

  def org_summery_params
    params.require(:org_summery).permit(:need_reports, :reported)
  end

  def set_org_summery
    @org = current_user.organization
    @org_summery = @org.today_org_summery
  end
end
