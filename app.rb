require 'fileutils'
require_relative './game_app'
require_relative './musicAlbum/music_album_ui'
require 'JSON'

class App
  def initialize
    @game = GameApp.new
    @music = MusicAlbumUI.new
  end

  def list_games
    @game.list_games
  end

  def list_authors
    @game.list_authors
  end

  def add_game
    @game.add_game
  end

  def preserve_data
    @game.preserve_data
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
