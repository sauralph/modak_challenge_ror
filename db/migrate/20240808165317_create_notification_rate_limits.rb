class CreateNotificationRateLimits < ActiveRecord::Migration[6.1]
  def change
    create_table :notification_rate_limits do |t|
      t.string :notification_type
      t.integer :limit
      t.integer :period

      t.timestamps
    end
  end
end
