require 'fileutils'
require_relative 'book_ui'
require_relative './musicAlbum/music_album_ui'
require 'JSON'

class App
  def initialize
    @book = BookUI.new
    @music = MusicAlbumUI.new
  end

  def list_books
    @book.list_books
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

  def list_labels
    @book.list_labels
  end

  def add_book
    @book.add_book
  end
end
