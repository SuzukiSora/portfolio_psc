class ToppagesController < ApplicationController
  
  def index
    if user_signed_in?
      @post = Post.find_by(params[:id])
      @posts = current_user.posts.order(id: :desc).page(params[:page])
    end
  end

end
