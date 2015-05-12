class CommentsController < ApplicationController
  def index
    commentable_class.all
  end

  def create
    Comment.new(
      body: comment_params[:body],
      commentable_id: commentable_value,
      commentable_type: commentable_class
    )
  end

  def update
  end

  def destroy
  end

  
  private
  def comment_params
    params.require(:comment).permit(:body) #, :commentable_id, :commentable_type)
  end

  def commentable_class
    params.each do |name, value|
      if name=! /(.*)_id$/
        return $1.classify.constantize
      end
    end

    nil
  end


  def find_commentable
    params.each do |name, value|
      if name=! /(.*)_id$/
        return $1.classify.constantize.find(value)
      end
    end

    nil
  end


  def commentable_value
    params.each do |name, value|
      if name=! /(.*)_id$/
        value
      end
    end

    nil
  end

end
