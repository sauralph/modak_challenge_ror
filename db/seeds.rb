# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
NotificationRateLimit.find_or_create_by!(notification_type: 'status') do |nrl|
  nrl.limit = 2
  nrl.period = 1.minute.to_i
end

NotificationRateLimit.find_or_create_by!(notification_type: 'news') do |nrl|
  nrl.limit = 1
  nrl.period = 1.day.to_i
end

NotificationRateLimit.find_or_create_by!(notification_type: 'marketing') do |nrl|
  nrl.limit = 3
  nrl.period = 1.hour.to_i
end
