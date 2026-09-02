class LikesController < ApplicationController
  def create
    begin
      binding.pry
      like = current_user.likes.create!(liked_user_id: params[:user_id])
    rescue => e
      logger.error(e.message)
      if e.class == ActiveRecord::RecordInvalid
        return redirect_to users_path, flash: {alert: 'いいねする相手が存在しません。'}
      elsif e.class == NoMethodError || e.class == ActiveModel::UnknownAttributeError || e.class == NameError
        return redirect_to users_path, flash: {alert: 'プログラムのコードに異常があるため、いいねできませんでした。'}
      else
        return redirect_to users_path, flash: {alert: '想定外のエラーのため、いいねできませんでした。'}
      end
    end
    if current_user.liked_users.exists?(user_id: like.user_id)
      redirect_to user_path(like.liked_user_id), notice: 'マッチングしました。'
    else
      redirect_to user_path(like.liked_user_id), notice: 'いいねしました。'
    end
  end

  def destroy
    begin
      like = current_user.likes.find(params[:id])
      like.destroy!
    rescue => e
      logger.error(e.message)
      if e.class == ActiveRecord::RecordNotFound
        return redirect_to users_path, flash: {alert: 'いいねを削除する相手が存在しません。'}
      elsif e.class == NoMethodError || e.class == NameError
        return redirect_to users_path, flash: {alert: 'プログラムのコードに異常があるため、いいねを削除できませんでした。'}
      else
        return redirect_to users_path, flash: {alert: '想定外のエラーのため、いいねを削除できませんでした。'}
      end
    end
    redirect_to user_path(like.liked_user_id), notice: 'いいねを削除しました。'
  end
end