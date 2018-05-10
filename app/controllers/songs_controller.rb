class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to artists_path, alert: "Artist not found."
    else
      @song = Song.new(artist_id: params[:artist_id])
    end
  end

  def create #accepts and sets artist_id
    if params[:artist_id]
      @artist = Artist.find(params[:artist_id])#set the artist
      if @artist.nil? || Artist.exists?(params[:artist]) #make sure the artist exists, is not nil
        redirect_to artists_path
      else #if the artist exists, create the song and add it to the artist collection
        @artist.songs.build(song_params)
        #@song = Song.new(song_params)
        #@artist.songs << @song
        @artist.save
      end
    else
      @song = Song.new(song_params)
    end

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path
      else
        @song = @artist.songs.find_by(id: params[:id])
        redirect_to artist_songs_path(@artist)
      end
    else
      @song = Song.find(params[:id])
    end

  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end
