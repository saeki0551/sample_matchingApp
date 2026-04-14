
class Users::SessionsController < Devise::SessionsController
  def create
    resource = resource_class.new(sign_in_params)
    resource = resource.get_latest_user(sign_in_params)
    if resource && resource.valid_password?(sign_in_params[:password])
      if resource.deleted_at.present?
        return redirect_to new_user_session_path, flash: { alert: 'ログインできません。再度、新規登録またはログインして下さい。' }
      end
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      return redirect_to new_user_session_path, flash: { alert: 'メールアドレスまたはパスワードが正しくありません。' }
    end
  end
end
