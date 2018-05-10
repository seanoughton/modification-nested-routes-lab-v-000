module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  def artist_select(song,artist)
    #if there is an artist already, then just show the artist, otherwise provide a list of ArtistsHelper

    if artist
      artist.name
    else
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    end
=begin
    if song.artist.nil?
         select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
     else
       hidden_field_tag "song[artist_id]", song.artist_id
     end
=end
  end
end
