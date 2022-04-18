namespace :notification do
  desc 'notify report'
  task daily_report: :environment do
    User.all.each do |user|
      user.send_daily_report_notify
    end
  end
end
