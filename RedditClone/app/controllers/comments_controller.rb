class CommentsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_author, except: :create


  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    flash[:errors] = @comment.errors.full_messages unless @comment.save
    redirect_to @comment.root_parent
  end

  def update
    @comment = Comment.find(params[:id])
    flash[:errors] = @comment.errors.full_messages unless @comment.update(comment_params)
    redirect_to @comment.root_parent
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.root_parent
  end


  private
  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :content, :parent_post_id)
  end

  def redirect_if_not_author
    comment = Comment.find(params[:id])
    redirect_to comment.root_parent unless comment.author == current_user
  end
end
