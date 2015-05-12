class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unproccessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    if User.destroy(user)
      render json: user
    else
      raise "unable to delete"
    end
  end

  def show
    render json: User.find(params[:id])
  end

  def update
    if User.update(params[:id], user_params)
      render json: User.find(params[:id])
    else
      render json: user.errors.full_messages, status: :unproccessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
