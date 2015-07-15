class AlbumsController < ApplicationController
  before_action :make_sure_user_is_logged_in

  def new
    @album = Album.new
    @album.band_id = params[:band_id]
    @bands = Band.all
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:messages] = ["Succesfully Created Album!"]
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.includes(:tracks).find(params[:id])
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      flash[:messages] = ["Successfully updated album"]
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to bands_url
  end

  private
  def album_params
    params.require(:album).permit(:title, :performance_type, :band_id)
  end
end
