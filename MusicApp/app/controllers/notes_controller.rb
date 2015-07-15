class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    @note.track_id = params[:track_id]
    @note.user_id = User.find_by(session_token: session[:session_token]).id

    if @note.save
      flash[:messages] = ["Successfully created note!"]
      redirect_to track_url(params[:track_id])
    else
      @track = Track.find(params[:track_id])
      flash.now[:errors] = @note.errors.full_messages
      render 'tracks/show'
    end
  end

  def update
    @note = Note.find(params[:id])

    if @note.save(updated_values)
      flash[:messages] = ["Successfully created note!"]
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @note.errors.full_messages
      render 'tracks/show'
    end
 
  end

  def destroy
    @note = Note.find(params[:id])
    @track = @note.track
    @note.destroy
    redirect_to track_url(@track)
  end

  private

  def note_params
    params.require(:note).permit(:note_text)
  end

  def updated_values
    { note_text: note_params[:note_text],
        user_id: User.find_by(session_token: session[:session_token]).id,
        track_id: params[:track_id] }
  end

end
