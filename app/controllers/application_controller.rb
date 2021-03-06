class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers
  before_action :line_messaging_login

  def authenticate_user
    return if current_user.present?

    redirect_to login_user_path
  end

  def redirect_to(path, options = {})
    if request.format.to_sym == :liff
      @path = path
      @options = options
      return render '/shareds/redirect', formats: :liff
    end
    options.except!(:size)
    puts '================================'
    puts options
    super path, options
  end

  def line_messaging_login
    Rails.logger.debug '================LOGIN================'
    user = User.from_kamigo(params)
    sign_in user if user.present?
  end
end
