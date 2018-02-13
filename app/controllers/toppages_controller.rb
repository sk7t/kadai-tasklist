class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @userid = current_user.userids.build  # form_for 用
      @userids = current_user.userids.order('created_at DESC').page(params[:page])
    end
  end
end