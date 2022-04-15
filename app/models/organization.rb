class Organization < ApplicationRecord
  has_many :users
  has_many :daily_reports
  has_many :today_daily_reports, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) },
           class_name: 'DailyReport'
  has_many :org_summeries
  has_one :today_org_summery, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) },
          class_name: 'OrgSummery'
end
