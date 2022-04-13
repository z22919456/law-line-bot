class Organization < ApplicationRecord
  has_many :users
  has_many :daily_reports
  has_many :org_summery
end
