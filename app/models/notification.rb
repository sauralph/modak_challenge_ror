class Notification < ApplicationRecord
  validates :notification_type, :recipient, :sent_at, presence: true
end
