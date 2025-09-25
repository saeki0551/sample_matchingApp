class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
<<<<<<< HEAD
  before_action :authenticate_user!
=======
>>>>>>> 6be23a0 (カラム編集)
  before_action :configure_permitted_parameters , if: :devise_controller?
<<<<<<<
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private 
  def after_sign_in_path_for(resource)
    users_path # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    new_user_session_path # ログアウト後に遷移するpathを設定
  end

end
