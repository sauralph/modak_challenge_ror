class NotificationRateLimit < ApplicationRecord
  validates :notification_type, :limit, :period, presence: true, uniqueness: true
  validates :limit , numericality: { only_integer: true, greater_than: 0 }
  validates :period, numericality: { only_integer: true, greater_than: 0 }
end
