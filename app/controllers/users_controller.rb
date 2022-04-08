class UsersController < ApplicationController
  include Kamigo::Clients::LineClient

  def edit
    Rails.logger.info user_line_omniauth_authorize_path
    repost(user_line_omniauth_authorize_path)
  end

  def update
    current_user.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:real_name, :organization_id, :company)
  end
end
