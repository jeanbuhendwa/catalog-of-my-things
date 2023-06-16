require 'fileutils'
require_relative './game_app'
require 'JSON'

class App
  def initialize
    @game = GameApp.new
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
end