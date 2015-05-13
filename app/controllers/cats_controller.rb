class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      # render :edit
      redirect_to edit_cat_url(@cat)
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    new_cat = Cat.new(cat_params)
    if new_cat.save
      redirect_to cat_url(new_cat)
    else
      render json: new_cat.errors.full_messages
    end
  end

  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end


#   Index/show pages
#
# Add a cats resource; generate a cats controller
# Build an index page of all Cats.
# Keep it simple; list the cats and link to the show pages.
# Build a show page for a single cat.
# Keep it simple; just show the cat's attributes.
# Learn how to use a table (table, tr, td, th tags) to format the cat's vital information.
end
