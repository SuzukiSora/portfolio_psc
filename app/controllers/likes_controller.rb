class LikesController < ApplicationController
  
  before_action :authenticate_user!
  

  def create
    like = Post.find(params[:like_id])
    current_user.like(like)
    flash[:success] = 'お気に入りに登録しまいした。'
    redirect_back(fallback_location: @user_path)
  end

  def destroy
    like = Post.find(params[:like_id])
    current_user.unlike(like)
    flash[:success] = 'お気に入りから削除しました。'
    redirect_back(fallback_location: @user_path)
  end

  private


end
