class HealthyTracking < ApplicationRecord
  belongs_to :user
  has_one :organization, through: :user
  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  validates :body_temperature, presence: { message: '記得量體溫喔' }
  validates :foot_step, presence: { message: '有沒有亂跑啊？' }
  validates :health_feels_today, presence: { message: '今天身體還好嗎？' }
  validates :health_feels_weeks, presence: { message: '這兩週身體還好嗎？' }
end
