class NotificationsController < ApplicationController
  def create
    recipient = params[:recipient]
    notification_type = params[:notification_type]

    service = NotificationService.new(recipient, notification_type)

    begin
      service.send_notification
      render json: { message: "Notification sent successfully" }, status: :ok
    rescue => e
      render json: { error: e.message }, status: :too_many_requests
    end
  end
end
