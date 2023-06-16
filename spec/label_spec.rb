require 'rspec'
require_relative '../item'
require_relative '../Book/label'

RSpec.describe Label do
  let(:title) { 'Sample Title' }
  let(:color) { 'red' }

  describe '#initialize' do
    it 'assigns a random ID' do
      label = Label.new(title, color)
      expect(label.id).to be_an(Integer)
      expect(label.id).to be >= 1
      expect(label.id).to be <= 1000
    end

    it 'assigns the provided title' do
      label = Label.new(title, color)
      expect(label.title).to eq(title)
    end

    it 'assigns the provided color' do
      label = Label.new(title, color)
      expect(label.color).to eq(color)
    end

    it 'initializes an empty array for items' do
      label = Label.new(title, color)
      expect(label.items).to be_an(Array)
      expect(label.items).to be_empty
    end
  end

  describe '#item_add' do
    it 'adds the item to the label' do
      label = Label.new('My Label', 'red')
      item = double('Item')
      expect(item).to receive(:label=).with(label)
      label.item_add(item)
      expect(label.items).to include(item)
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the object' do
      label = Label.new('color', 'green')
      check = label.to_json
      expected_result = { 'id' => label.id, 'title' => 'color', 'color' => 'green' }
      expect(check).to eq(expected_result)
    end
  end
end
