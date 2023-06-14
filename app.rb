require 'fileutils'
require_relative './musicAlbum/music_album_ui'
require 'JSON'

class App
  def initialize
    @music = MusicAlbumUI.new
  end

  def list_music_albums
    @music.list_music_album
  end

  def list_genres
    @music.list_genre
  end

  def add_music_album
    @music.add_music_album
  end
end
