class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers
  before_action :line_messaging_login

  def authenticate_user
    return if current_user.present?

    redirect_to user_line_omniauth_authorize_path
  end

  def liff_redirect_to(path, options = {})
    if request.format.to_sym == :liff
      @path = path
      @options = options
      return render '/shareds/liff_redirect', formats: :liff
    end
    redirect_to path
  end

  def line_messaging_login
    Rails.logger.debug '================LOGIN================'
    user = User.from_kamigo(params)
    sign_in user if user.present?
  end
end
