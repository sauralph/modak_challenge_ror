class NotificationRateLimit < ApplicationRecord
  validates :notification_type, :limit, :period, presence: true
end
