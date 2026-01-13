class LikesController < ApplicationController
  protect_from_forgery except: :create #InvalidCrossOriginRequest CSRF(クロスサイトリクエストフォージェリ) CSRF対策として、RailsがフォームやらAjaxやらで、トークンを発行して認証までしてくれています。 ほとんどの場合、何も気にすることなく、勝手に認証されているのではないでしょうか。その、認証に失敗した場合に、InvalidCrossOriginRequestが発生します。

  def create
    @like = Like.new(user_id: params[:user_id], liked_user_id: params[:liked_user_id])
    @like.save
  end

  def destroy
    like = Like.find_by(user_id: params[:user_id], liked_user_id: params[:liked_user_id])
    if like.destroy
      redirect_to users_path
    else
      redirect_to users_path, alert: "いいねが削除できませんでした。"
    end
  end
end