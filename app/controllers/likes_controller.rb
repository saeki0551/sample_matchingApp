class LikesController < ApplicationController
  def create
    begin
      @like = current_user.likes.create!(liked_user_id: params[:user_id])
    rescue ActiveRecord::RecordInvalid => e
      logger.error e
      if current_user.likes.exists?(liked_user_id: params[:user_id])
        return redirect_to users_path, flash: {alert: '既にいいねしています'}
      else
        return redirect_to users_path, flash: {alert: 'いいねする相手が存在しません。'}
      end
    end
    if current_user.liked_by?(user_id: @like.liked_user.id)
      flash[:notice] = 'マッチングしました。'
    else
      flash[:notice] = 'いいねしました。'
    end
  end

  def destroy
    begin
      @like = current_user.likes.find(params[:id])
      @like.destroy!
    rescue ActiveRecord::RecordNotFound => e
      logger.error e
      return redirect_to users_path, flash: {alert: 'いいねする相手が存在しません。'}
    end
    flash[:notice] = 'いいねを削除しました。'
  end
end