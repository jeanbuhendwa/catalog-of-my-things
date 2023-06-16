require 'rspec'
require_relative '../item'
require_relative '../Book/label'

RSpec.describe Label do
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
