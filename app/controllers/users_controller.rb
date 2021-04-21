class UsersController < ApplicationController
  
  before_action :authenticate_user!, only: [:index, :show, :edit]


  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def show
    set_user
    @relationship = current_user.relationships.find_by(follow_id: @user.id)  
    @set_relationship = current_user.relationships.new
    @posts = @user.posts.order(id: :desc).page(params[:page])
  end

  def edit
    set_user
  end

  def update
    set_user
    @user.update(user_params)
    redirect_to root_path
  end

  def followings
    set_user
    @followings = @user.followings.all
  end
  
  def followers
    set_user
    @followers = @user.followers.all
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.likings.page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :comment, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end


end
