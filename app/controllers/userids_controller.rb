class UseridsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @userid = current_user.userids.build(userid_params)
    if @userid.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @userids = current_user.userids.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @userid.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def userid_params
    params.require(:userid).permit(:content)
  end
  
  def correct_user
    @userid = current_user.userids.find_by(id: params[:id])
    unless @userid
      redirect_to root_url
    end
  end
end
