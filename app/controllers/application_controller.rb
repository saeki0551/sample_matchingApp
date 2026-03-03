class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!

  ACCOUNT_STOP_TIME = 100

  private 

    def after_sign_in_path_for(resource)
      if user_signed_in? 
        users_path
      else
        new_user_information_path
      end
    end

    def after_sign_out_path_for(resource)
      new_user_session_path # ログアウト後に遷移するpathを設定
    end
end
