require 'rspec'
require_relative '../Book/book'

RSpec.describe Book do
  let(:publisher) { 'Sample Publisher' }
  let(:cover_state) { 'good' }
  let(:publish_date) { '2023-01-01' }

  describe '#initialize' do
    it 'assigns a random ID' do
      book = Book.new(publisher, cover_state, publish_date)
      expect(book.id).to be_an(Integer)
      expect(book.id).to be >= 1
      expect(book.id).to be <= 1000
    end

    it 'assigns the provided publisher' do
      book = Book.new(publisher, cover_state, publish_date)
      expect(book.publisher).to eq(publisher)
    end

    it 'assigns the provided cover state' do
      book = Book.new(publisher, cover_state, publish_date)
      expect(book.cover_state).to eq(cover_state)
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if parent returns true' do
      book = Book.new('No Starch Press', 'good', '2001-01-01')
      test_method = book.can_be_archived?
      expect(test_method).to eq(true)
    end
  end

  describe '#can_be_archived?' do
    it 'returns false if parent returns false' do
      book = Book.new('No Starch Press', 'good', '2022-01-01')
      test_method = book.can_be_archived?
      expect(test_method).to eq(false)
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the object' do
      book = Book.new('test', 'bad', '2020-02-27')
      check = book.to_json
      result = {
        'id' => book.id,
        'publisher' => 'test',
        'cover_state' => 'bad',
        'publish_date' => book.publish_date
      }
      expect(check).to eq(result)
    end
  end
end
