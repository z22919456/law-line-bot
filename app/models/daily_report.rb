class DailyReport < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :organization, optional: true

  default_scope { order(created_at: :desc) }
  # 今日表單
  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
  # 在七天內有回報接觸者
  scope :last_touch_in_7_days, -> { where('touch_date > ?', Time.zone.now + 7.days).size > 1 }

  enum answered: { need_isolation: '1', touched_diagnosed: '2', normal: '3', need_report: '4',
                   be_notified_need_report: '5' }

  validates :answered, presence: { message: '請選擇一個選項' }

  # 是否已完成本次紀錄
  def completed?
    return true if normal?

    return true if touch_date.present? && touch_location.present?

    false
  end
end
