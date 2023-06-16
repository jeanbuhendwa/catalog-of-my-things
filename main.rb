require_relative './app'

def run_option
  puts 'Kindly choose an option'
  puts '1-:List all books'
  puts '2-:List all music albums'
  puts '3-:List of games'
  puts '4-:List all genres '
  puts '5-:List all labels '
  puts '6-:List all authors '
  puts '7-:Add a book'
  puts '8-:Add a music album'
  puts '9-:Add a game'
  puts '10-: Exit/Quit'
end

public

def handle_option(option, app) # rubocop:disable Metrics/CyclomaticComplexity
  case option
  when 1
    app.list_books
    true
  when 2
    app.list_music_albums
    true
  when 3
    app.list_games
    true
  when 4
    app.list_genres
    true
  when 5
    app.list_labels
    true
  when 6
    app.list_authors
    true
  when 7
    app.add_book

  when 8
    app.add_music_album
  when 9
    app.add_game
  when 10
    puts 'Thanks You!!...'
    app.preserve_data
    false
  end
end

def main
  app = App.new
  status = true
  puts 'Welcome to our App console!'
  while status
    run_option
    option = gets.chomp.to_i
    status = handle_option(option, app)
    status = false if option == 10
  end
end

main
