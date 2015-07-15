class PostsController < ApplicationController
  before_action :redirect_if_not_logged_in, except: [:show, :index]
  before_action :redirect_if_not_author, only: [:update, :destroy, :edit]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to @post
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.includes(:author).find(params[:id])
    @all_comments = @post.comments_by_parent_id
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to subs_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url, sub_ids:  [])
  end

  def redirect_if_not_author
    post = Post.find(params[:id])
    redirect_to post unless post.author == current_user
  end
end
