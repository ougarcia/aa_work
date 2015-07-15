class TracksController < ApplicationController
  before_action :make_sure_user_is_logged_in

  def new
    @track = Track.new
    @albums = Album.all
    @track.album_id = params[:album_id]
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:messages] = ["Successfully Created Track!"]
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all
  end

  def show
    @track = Track.includes(:notes).find(params[:id])
    @note = Note.new
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      flash[:messages] = ["Succesffully Created Track!"]
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      render :edi
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to bands_url
  end

  private
  def track_params
    params.require(:track).permit(:title, :track_type, :album_id, :lyrics)
  end
end
