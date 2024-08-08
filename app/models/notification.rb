class Notification < ApplicationRecord
  validates :notification_type, :recipient, :sent_at, presence: true
  validates :recipient, format: { with: URI::MailTo::EMAIL_REGEXP }
end
