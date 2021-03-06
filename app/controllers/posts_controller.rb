class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update post_params
        redirect_to @post
    else 
      render 'edit'
    end
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
