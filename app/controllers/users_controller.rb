class UsersController < ApplicationController
  include Kamigo::Clients::LineClient
  before_action :line_messaging_login
  def edit; end

  def update
    current_user.update(user_params)
  end

  def line_messaging_login
    Rails.logger.debug '================LOGIN================'
    user = User.from_kamigo(params)
    sign_in user if user.present?
  end

  private

  def user_params
    params.require(:user).permit(:name, :org, :company)
  end
end
