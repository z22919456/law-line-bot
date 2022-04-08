class UsersController < ApplicationController
  include Kamigo::Clients::LineClient

  def show; end

  def update
    if current_user.update(user_params)
      render :show, formats: :liff
    else
      render :edit, formats: :liff
    end
  end

  def index; end

  private

  def user_params
    params.require(:user).permit(:real_name, :organization_id, :eno)
  end
end
