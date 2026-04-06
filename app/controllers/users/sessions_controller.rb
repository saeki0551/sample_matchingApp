
class Users::SessionsController < Devise::SessionsController
  def create
    user = User.order(id: :desc).find_by(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      resource = user
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが正しくありません。'
      render :new
    end
    # 一度退会したらログインできなくなってしまう
    if resource.deleted_at.present?
      return redirect_to new_user_session_path, flash: { alert: "（退会中のため？）ログインできませんでした。" }
    end
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end
end
