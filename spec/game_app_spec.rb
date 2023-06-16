require 'rspec'
require_relative '../game_app'

RSpec.describe GameApp do
  let(:game_app) { GameApp.new }

  describe '#create_author' do
    it 'creates a new author object' do
      allow(game_app).to receive(:author_inputs).and_return({
                                                              first_name: 'Eduardo',
                                                              last_name: 'Villarreal'
                                                            })

      author = game_app.create_author

      expect(author).to be_a(Author)
      expect(author.first_name).to eq('Eduardo')
      expect(author.last_name).to eq('Villarreal')
    end
  end

  describe '#select_author' do
    before do
      allow(game_app).to receive(:gets).and_return('1\n')
    end

    it 'returns the selected author index' do
      expect(game_app.select_author).to eq(1)
    end
  end

  describe '#list_games' do
    it 'prints the list of games' do
      author = Author.new('Eduardo', 'Villarreal')
      game = Game.new('2023/06', 'yes', '2023/06/10')
      author.add_item(game)
      game_app.authors << author
      game_app.games << game

      expect { game_app.list_games }.to output(
        "Published date: 2023-06-01\n" \
        "Multiplayer: yes\n" \
        "Last played: 2023-06-10\n" \
        "Author: Eduardo Villarreal\n\n"
      ).to_stdout
    end

    it 'prints a message for empty game list' do
      expect { game_app.list_games }.to output("No games created yet\n").to_stdout
    end
  end

  describe '#list_authors' do
    it 'prints the list of authors' do
      author1 = Author.new('Eduardo', 'Villarreal')
      author2 = Author.new('Eduardo', 'Zevallos')
      game_app.authors << author1 << author2

      expect { game_app.list_authors }.to output(
        "Eduardo Villarreal\n" \
        "Eduardo Zevallos\n"
      ).to_stdout
    end

    it 'prints a message for empty author list' do
      expect { game_app.list_authors }.to output("No authors yet added\n").to_stdout
    end
  end

  describe '#load_data' do
    it 'loads game data from a JSON file' do
      game_data = '[
        {
          "publish_date": "2023-06-01",
          "multiplayer": "yes",
          "last_played_at": "2023-06-10",
          "author": {
            "first_name": "Eduardo",
            "last_name": "Villarreal"
          }
        }
      ]'
      json_data = game_data
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:read).and_return(json_data)

      game_app.load_data

      expect(game_app.games.size).to eq(2)
      expect(game_app.games[1].publish_date).to eq(Date.parse('2023/06'))
      expect(game_app.games[1].multiplayer).to eq('yes')
      expect(game_app.games[1].last_played_at).to eq(Date.parse('2023/06/10'))
      expect(game_app.authors.size).to eq(1)
      expect(game_app.authors[0].first_name).to eq('Eduardo')
      expect(game_app.authors[0].last_name).to eq('Villarreal')
    end

    it 'does not load data if the file does not exist' do
      allow(File).to receive(:exist?).and_return(false)

      game_app.load_data

      expect(game_app.games).to be_empty
      expect(game_app.authors).to be_empty
    end
  end

  describe '#game_inputs' do
    it 'returns a hash with game inputs' do
      allow(game_app).to receive(:get_input).and_return('2023/06', 'yes', '2023/06/10')

      inputs = game_app.game_inputs

      expect(inputs).to eq({
                             publish_date: '2023/06',
                             multiplayer: 'yes',
                             last_played_at: '2023/06/10'
                           })
    end
  end

  describe '#author_inputs' do
    it 'returns a hash with author inputs' do
      allow(game_app).to receive(:get_input).and_return('Eduardo', 'Villarreal')

      inputs = game_app.author_inputs

      expect(inputs).to eq({
                             first_name: 'Eduardo',
                             last_name: 'Villarreal'
                           })
    end
  end

  describe '#create_game' do
    it 'creates a new game object' do
      allow(game_app).to receive(:game_inputs).and_return({
                                                            publish_date: '2023/06',
                                                            multiplayer: 'yes',
                                                            last_played_at: '2023/06/10'
                                                          })

      game = game_app.create_game

      expect(game).to be_a(Game)
      expect(game.publish_date).to eq(Date.parse('2023/06'))
      expect(game.multiplayer).to eq('yes')
      expect(game.last_played_at).to eq(Date.parse('2023/06/10'))
    end
  end

  describe '#add_game' do
    before do
      allow(game_app).to receive(:create_game).and_return(Game.new('2023/06', 'yes', '2023/06/10'))
      allow(game_app).to receive(:select_author).and_return(0)
      allow(game_app).to receive(:create_author).and_return(Author.new('Eduardo', 'Villarreal'))
    end

    it 'adds a game with an author' do
      expect { game_app.add_game }.to change { game_app.games.size }.by(1)
      expect(game_app.games.last).to be_a(Game)
      expect(game_app.games.last.publish_date).to eq(Date.parse('2023/06'))
      expect(game_app.games.last.multiplayer).to eq('yes')
      expect(game_app.games.last.last_played_at).to eq(Date.parse('2023/06/10'))

      expect(game_app.authors.size).to eq(1)
      expect(game_app.authors.last).to be_a(Author)
      expect(game_app.authors.last.first_name).to eq('Eduardo')
      expect(game_app.authors.last.last_name).to eq('Villarreal')
    end
  end
end