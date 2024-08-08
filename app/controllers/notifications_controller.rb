class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  def index
    @notifications = Notification.all
  end

  def show
  end

  def new
    @notification = Notification.new
  end

  def edit
  end

  def create
    recipient = params[:notification][:recipient]
    notification_type = params[:notification][:notification_type]

    service = NotificationService.new(recipient, notification_type)

    begin
      service.send_notification
      redirect_to notifications_path, notice: 'Notification sent successfully.'
    rescue => e
      @notification = Notification.new(notification_params)
      @notification.errors.add(:base, e.message)
      render :new
    end
  end

  def update
    if @notification.update(notification_params)
      redirect_to @notification, notice: 'Notification updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @notification.destroy
    redirect_to notifications_url, notice: 'Notification deleted successfully.'
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to notifications_url, alert: 'Notification not found.'
  end

  def notification_params
    params.require(:notification).permit(:notification_type, :recipient, :sent_at)
  end
end
