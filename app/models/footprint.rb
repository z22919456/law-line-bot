class Footprint < ApplicationRecord
  before_commit :send_line_notification

  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).first }

  def send_line_notification
    return unless created_at.today?

    self.class.client.broadcast(create_flex_message_json)
  end

  private

  def create_flex_message_json
    {
      type: 'text',
      text: "$ 防疫小組快訊息 $\n\n#{Date.today.strftime('%m/%d')} 🦶🏻全國各縣市足跡通報整理 \n#{pdf_url}\n\n#{note}",
      emojis: [
        {
          index: 0,
          productId: '5ac21a18040ab15980c9b43e',
          emojiId: '025'
        },
        {
          index: 10,
          productId: '5ac21a18040ab15980c9b43e',
          emojiId: '025'
        }
      ]
    }
  end
end
