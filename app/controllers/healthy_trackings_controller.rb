class HealthyTrackingsController < ApplicationController
  before_action :need_track?, only: %i[new edit update]
  before_action :set_healthy_tracking, only: %i[new show edit update]

  def new
    redirect_to action: :edit if @healthy_tracking.present?
    @healthy_tracking = current_user.healthy_trackings.new
  end

  def edit
    redirect_to action: :new if @healthy_tracking.nil?
  end

  def show
    redirect_to action: :new if @healthy_tracking.nil?
  end

  def create
    @healthy_tracking = current_user.healthy_trackings.create(healthy_tracking_params)
    return redirect_to action: :show if @healthy_tracking.errors.empty?

    render :new
  end

  def update
    return redirect_to action: :show if @healthy_tracking.update(healthy_tracking_params)

    render :edit
  end

  def not_need; end

  private

  def set_healthy_tracking
    @healthy_tracking = current_user.today_healthy_tracking
  end

  def healthy_tracking_params
    params.require(:healthy_tracking).permit(:body_temperature, :foot_step, :health_feels_today, :health_feels_weeks)
  end

  def need_track?
    redirect_to action: :not_need unless current_user.need_tracking?
  end
end
