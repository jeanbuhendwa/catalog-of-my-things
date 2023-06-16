require 'rspec'
require_relative '../gameAuthor/game'

RSpec.describe Game do
  let(:publish_date) { Date.new(2021, 1, 1).to_s }
  let(:multiplayer) { true }
  let(:last_played_at) { Date.new(2022, 6, 15).to_s }

  subject(:game) { Game.new(publish_date, multiplayer, last_played_at) }

  describe '#initialize' do
    it 'sets the publish_date, multiplayer, and last_played_at attributes' do
      expect(game.publish_date.to_s).to eq(publish_date)
      expect(game.multiplayer).to eq(multiplayer)
      expect(game.last_played_at.to_s).to eq(last_played_at)
    end

    it 'converts the last_played_at parameter to a Date object' do
      expect(game.last_played_at).to be_a(Date)
    end
  end

  describe '#can_be_archived?' do
    context 'when the game can be archived' do
      it 'returns true if the item can be archived and last_played_at is more than two years ago' do
        allow(game).to receive(:super).and_return(true)
        two_years_ago = Date.today - (2 * 365)
        ten_years_ago = Date.today - (10 * 365)
        game.last_played_at = two_years_ago - 1
        game.publish_date = ten_years_ago - 1
        expect(game.can_be_archived?).to be(true)
      end
    end

    context 'when the game cannot be archived' do
      it 'returns false if the item cannot be archived' do
        allow(game).to receive(:super).and_return(false)
        game.last_played_at = Date.today - 1

        expect(game.can_be_archived?).to be(false)
      end

      it 'returns false if last_played_at is within the last two years' do
        allow(game).to receive(:super).and_return(true)
        two_years_ago = Date.today - (2 * 365)
        game.last_played_at = two_years_ago + 1

        expect(game.can_be_archived?).to be(false)
      end
    end
  end
end
