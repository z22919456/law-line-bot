class Organization < ApplicationRecord
  has_many :users
  has_many :daily_reports
end
