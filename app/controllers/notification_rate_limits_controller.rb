class NotificationRateLimitsController < ApplicationController
  before_action :set_notification_rate_limit, only: [:show, :edit, :update, :destroy]

  def index
    @notification_rate_limits = NotificationRateLimit.all
  end

  def show
  end

  def new
    @notification_rate_limit = NotificationRateLimit.new
  end

  def edit
  end

  def create
    @notification_rate_limit = NotificationRateLimit.new(notification_rate_limit_params)

    if @notification_rate_limit.save
      redirect_to @notification_rate_limit, notice: 'Notification rate limit was successfully created.'
    else
      render :new
    end
  end

  def update
    if @notification_rate_limit.update(notification_rate_limit_params)
      redirect_to @notification_rate_limit, notice: 'Notification rate limit was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @notification_rate_limit.destroy
    redirect_to notification_rate_limits_url, notice: 'Notification rate limit was successfully destroyed.'
  end

  private

  def set_notification_rate_limit
    @notification_rate_limit = NotificationRateLimit.find(params[:id])
  end

  def notification_rate_limit_params
    params.require(:notification_rate_limit).permit(:notification_type, :limit, :period)
  end
end
