class UsersController < ApplicationController
  include Kamigo::Clients::LineClient
  before_action :authenticate_user

  def show; end

  def update
    if current_user.update(user_params)
      render action: :show
    else
      render :edit
    end
  end

  def edit; end

  def login
    render :login
  end

  private

  def user_params
    params.require(:user).permit(:real_name, :organization_id, :eno, :role)
  end
end
