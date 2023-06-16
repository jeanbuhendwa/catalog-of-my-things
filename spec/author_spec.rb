require 'rspec'
require_relative '../gameAuthor/author'
require_relative '../item'

describe Author do
  let(:author) { Author.new('Eduardo', 'Villarreal') }

  describe '#initialize' do
    it 'sets the first_name and last_name attributes' do
      expect(author.first_name).to eq('Eduardo')
      expect(author.last_name).to eq('Villarreal')
    end

    it 'generates a random id between 1 and 300' do
      expect(author.id).to be_between(1, 300)
    end

    it 'initializes an empty items array' do
      expect(author.items).to be_an(Array)
      expect(author.items).to be_empty
    end
  end

  describe '#add_item' do
    let(:item) { Item.new('2020/04') }

    it 'adds the item to the items array' do
      author.add_item(item)
      expect(author.items).to include(item)
    end

    it 'sets the author of the item to self' do
      expect(item).to receive(:author=).with(author)
      author.add_item(item)
    end
  end
end
