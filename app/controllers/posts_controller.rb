class PostsController < ApplicationController
  def index
    @posts = Post.all.decorate
  end

  def new
    if not user_signed_in?
      redirect_to status: 404
    end
  end

  def show
    #@post = Post.find(params[:id])
    post
  end

  def edit
    @post = Post.find(params[:id])
    if not user_signed_in?
      redirect_to @post
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update post_params
        redirect_to @post
    else 
      render 'edit'
    end
  end

  def post
    @post ||= PostFinder.run params[:id] 
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to @post
  end

  def post_params
    params.require(:post).permit(:title,:content)
  end
end
