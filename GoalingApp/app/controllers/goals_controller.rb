class GoalsController < ApplicationController
  before_action :require_login

  def index
    @goals = Goal.public_goals
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to @goal
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal && @goal.update(goal_params)
      redirect_to @goal
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  private
  def goal_params
    params.require(:goal).permit(:objective, :publicized, :completed)
  end

end
