class OrgSummery < ApplicationRecord
  belongs_to :organization
  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
  validates :need_reports, presence: { message: '請回報人數' }
  validates :reported, presence: { message: '請回報人數' }
  validates_numericality_of :reported, greater_than_or_equal_to: 0, message: '貴單位人數不能為負的'
  validates_numericality_of :need_reports, greater_than_or_equal_to: 0, message: '貴單位人數不能為負的'
end
