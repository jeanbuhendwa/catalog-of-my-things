require 'json'
require_relative './gameAuthor/game'
require_relative './gameAuthor/author'

class GameApp
  attr_accessor :games, :authors, :item

  def initialize
    @games = []
    @authors = []
    @path = './storage/games.json'
    load_data
  end

  def get_input(prompt)
    print prompt
    gets.chomp
  end

  def game_inputs
    publish_date = get_input('Publish date(YYYY/MM): ')
    multiplayer = get_input('Is it a multiplayer game?: ')
    last_played_at = get_input('When was the game last played?(YYYY/MM): ')
    {
      publish_date: publish_date,
      multiplayer: multiplayer,
      last_played_at: last_played_at
    }
  end

  def author_inputs
    first_name = get_input('Insert authors first name: ')
    last_name = get_input('Insert authors last name: ')
    {
      first_name: first_name,
      last_name: last_name
    }
  end

  def create_game
    inputs = game_inputs
    Game.new(inputs[:publish_date], inputs[:multiplayer], inputs[:last_played_at])
  end

  def create_author
    inputs = author_inputs
    Author.new(inputs[:first_name], inputs[:last_name])
  end

  def select_author
    puts 'Select an option for the author of the game'
    puts '0) Create a new Author'
    @authors.each_with_index do |author, index|
      puts "#{index + 1}) #{author.first_name} #{author.last_name} "
    end
    gets.chomp.to_i
  end

  def add_game
    game = create_game
    selected = select_author
    author = if selected.zero?
               create_author
             else
               @authors[selected - 1]
             end
    add_author_game(author, game)
    puts "Game and author added succesfully"
    preserve_data
  end

  def add_author_game(author, game)
    author.add_item(game)
    unless @authors.any? do |author_element|
             author_element.first_name == author.first_name && author_element.last_name == author.last_name
           end
      @authors.push(author)
    end
    @games.push(game)
  end

  def list_games
    if @games.empty?
      puts 'No games created yet'
    else
      @games.each do |game|
        puts "Published date: #{game.publish_date}"
        puts "Multiplayer: #{game.multiplayer}"
        puts "Last played: #{game.last_played_at}"
        puts "Author: #{game.author.first_name} #{game.author.last_name}"
        puts ''
      end
    end
  end

  def list_authors
    if @authors.empty?
      puts 'No authors yet added'
    else
      @authors.each do |author|
        puts "#{author.first_name} #{author.last_name}"
      end
    end
  end

  def preserve_data
    games = @games.map do |game|
      {
        publish_date: game.publish_date,
        multiplayer: game.multiplayer,
        last_played_at: game.last_played_at,
        author: {
          first_name: game.author.first_name,
          last_name: game.author.last_name
        }
      }
    end
    games_collection = games.to_json
    File.write(@path, games_collection)
  end

  def load_data
    return unless File.exist?(@path)

    data = File.read(@path)
    games = JSON.parse(data)
    games.map do |game|
      game_object = Game.new(game['publish_date'], game['multiplayer'], game['last_played_at'])
      author_object = Author.new(game['author']['first_name'], game['author']['last_name'])
      add_author_game(author_object, game_object)
    end
  end
end
