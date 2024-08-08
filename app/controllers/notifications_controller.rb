class NotificationsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  before_action :set_notification_types, only: [:new, :edit, :create, :update]

  def index
    @notifications = Notification.all

    respond_to do |format|
      format.html # renders index.html.erb
      format.json { render json: @notifications }
    end
  end

  def show
    respond_to do |format|
      format.html # renders show.html.erb
      format.json { render json: @notification }
    end
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
      respond_to do |format|
        format.html { redirect_to notifications_path, notice: 'Notification sent successfully.' }
        format.json { render json: { message: 'Notification sent successfully' }, status: :created }
      end
    rescue => e
      @notification = Notification.new(notification_params)
      @notification.errors.add(:base, e.message)
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { error: e.message }, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @notification.update(notification_params)
      respond_to do |format|
        format.html { redirect_to @notification, notice: 'Notification updated successfully.' }
        format.json { render json: { message: 'Notification updated successfully' }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification deleted successfully.' }
      format.json { render json: { message: 'Notification deleted successfully' }, status: :ok }
    end
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to notifications_url, alert: 'Notification not found.' }
      format.json { render json: { error: 'Notification not found' }, status: :not_found }
    end
  end

  def set_notification_types
    @notification_types = NotificationRateLimit.pluck(:notification_type).uniq
  end

  def notification_params
    params.require(:notification).permit(:notification_type, :recipient, :sent_at, :body)
  end
end
