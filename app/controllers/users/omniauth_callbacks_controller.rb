module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token
    def line
      user = User.from_omniauth(request.env['omniauth.auth'])
      sign_in user
      redirect_to root_path
    end
  end
end
