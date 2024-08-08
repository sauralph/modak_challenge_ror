class NotificationService
  def initialize(recipient, notification_type)
    @recipient = recipient
    @notification_type = notification_type.to_s
    @rate_limit = NotificationRateLimit.find_by(notification_type: @notification_type)
    raise "Rate limit not defined for #{@notification_type}" unless @rate_limit
  end

  def send_notification
    if rate_limited?
      raise "Rate limit exceeded for #{@notification_type} notifications to #{@recipient}"
    else
      # Your logic to send the email notification
      Notification.create!(notification_type: @notification_type, recipient: @recipient, sent_at: Time.current)
      puts "Notification sent to #{@recipient}"
    end
  end

  private

  def rate_limited?
    recent_notifications.count >= @rate_limit.limit
  end

  def recent_notifications
    Notification.where(notification_type: @notification_type, recipient: @recipient)
                .where('sent_at > ?', Time.current - @rate_limit.period.seconds)
  end
end
