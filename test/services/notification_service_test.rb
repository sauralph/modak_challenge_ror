require 'test_helper'

class NotificationServiceTest < ActiveSupport::TestCase
  def setup
    @recipient = 'user@example.com'
    @notification_type = 'status'
    @rate_limit = notification_rate_limits(:status_limit)
  end

  test 'sends the notification when under the rate limit' do
    service = NotificationService.new(@recipient, @notification_type)
    assert_difference 'Notification.count', 1 do
      service.send_notification
    end
  end

  test 'raises error when over the rate limit' do
    notifications(:one)
    Notification.create!(notification_type: @notification_type, recipient: @recipient, sent_at: Time.current)

    service = NotificationService.new(@recipient, @notification_type)
    assert_raises(RuntimeError, 'Rate limit exceeded for status notifications to user@example.com') do
      service.send_notification
    end
  end

  test 'raises error when rate limit is not defined' do
    undefined_notification_type = 'undefined_type'
    assert_raises(RuntimeError, "Rate limit not defined for #{undefined_notification_type}") do
      NotificationService.new(@recipient, undefined_notification_type)
    end
  end
end
