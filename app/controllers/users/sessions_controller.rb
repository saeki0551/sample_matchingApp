
class Users::SessionsController < Devise::SessionsController
  def create
    resource = warden.authenticate!(auth_options)
    if resource.deleted_at
      sign_out(resource)
      return redirect_to new_user_session_path, flash: { alert: "（退会中のため？）ログインできませんでした。" }
    end
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end
end
