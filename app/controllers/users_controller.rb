class UsersController < ApplicationController
  include Kamigo::Clients::LineClient

  def show; end

  def update
    if current_user.update(user_params)
      render action: :show
    else
      render :edit
    end
  end

  def edit; end

  private

  def user_params
    params.require(:user).permit(:real_name, :organization_id, :eno, :role)
  end
end
