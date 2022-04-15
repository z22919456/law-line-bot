class DailyReport < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :organization, optional: true
  after_commit :set_tracking_date

  default_scope { order(created_at: :desc) }

  enum answered: { need_isolation: '1', touched_diagnosed: '2', normal: '3', need_report: '4',
                   be_notified_need_report: '5' }
  validates :answered, presence: { message: '請選擇一個選項' }

  # 是否已完成本次紀錄
  def completed?
    return true if normal?

    return true if touch_date.present? && touch_location.present?

    false
  end

  def set_tracking_date
    return if need_tracking_till.present? || touch_date.nil?

    update(need_tracking_till: touch_date + 7.days)
  end
end
