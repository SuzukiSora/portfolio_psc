class PostsController < ApplicationController
  
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def show
    set_post
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render new_post_path
    end
  end

  def edit
    set_post
  end

  def update
    set_post
    @post.update(post_params)
    redirect_to root_path
  end


  private

  def set_post 
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :cast, :year, :summary, :image)
  end

  # def correct_user
  #   @post = current_user.posts.find_by(id: params[:id])
  #   unless @post
  #     redirect_to root_url
  #   end
  # end

end
