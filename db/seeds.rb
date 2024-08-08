# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
NotificationRateLimit.create!(notification_type: 'status', limit: 2, period: 1.minute.to_i)
NotificationRateLimit.create!(notification_type: 'news', limit: 1, period: 1.day.to_i)
NotificationRateLimit.create!(notification_type: 'marketing', limit: 3, period: 1.hour.to_i)
