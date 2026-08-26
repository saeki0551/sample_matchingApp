class LikesController < ApplicationController
  def create
    begin
      like = current_user.likes.create!(liked_user_id: like_user_id_params[:user_id])
    rescue => e
      logger.error(e.message)
      if e.class == ActiveRecord::RecordInvalid
        return redirect_to users_path, flash: {alert: 'いいねする相手が存在しません。'}
      elsif e.class == NoMethodError || e.class == ActiveModel::UnknownAttributeError
        return redirect_to users_path, flash: {alert: 'プログラムのコードに異常があるため、いいねできませんでした。'}
      else
        return redirect_to users_path, flash: {alert: '想定外のエラーのため、いいねできませんでした。'}
      end
    end
    if current_user.liked_users.exists?(user_id: like_user_id_params[:user_id])
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
      # エラー処理分ける
      return redirect_to users_path, flash: {alert: 'いいねが削除できませんでした。'}
    end
    redirect_to user_path(like.liked_user_id), notice: 'いいねを削除しました。'
  end

  private

    def like_user_id_params
      params.permit(:user_id)
    end
end