# 發送訊息取得回應
class CommandsController < ApplicationController
  include Kamigo::Clients::LineClient

  def daily_report
    return unless manager?

    @org = current_user.organization
  end

  private

  def manager?
    true
    # current_user.is_manager
  end
end
