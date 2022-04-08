class UsersController < ApplicationController
  include Kamigo::Clients::LineClient

  def edit; end

  def update
    current_user.update(user_params)
    render :edit, formats: :liff
  end

  def index; end

  private

  def user_params
    params.require(:user).permit(:real_name, :organization_id, :eno)
  end
end
