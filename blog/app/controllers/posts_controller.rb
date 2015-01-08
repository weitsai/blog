class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
  end

  def create
    @post = Post.new(posts_params)
    @post.save
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(posts_params)
      redirect_to @post
    else
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

private
  def posts_params
    params.require(:post).permit(:title, :content)
  end

end
