require_relative '../item'

describe Item do
  before :each do
    @item = Item.new('2010-01-01')
  end

  it 'Test for Item instance' do
    expect(@item).to be_instance_of Item
  end

  it 'Test for genre attribute' do
    expect(@item.genre).to be_nil
    fiction = Genre.new('Fiction')
    @item.genre = fiction
    expect(@item.genre.name).to eq('Fiction')
  end

  it 'Test for author attribute' do
    expect(@item.author).to be_nil
    john = Author.new('John', 'Doe')
    @item.author = john
    expect(@item.author.first_name).to eq('John')
    expect(@item.author.last_name).to eq('Doe')
  end

  it 'Test for label attribute' do
    expect(@item.label).to be_nil
    publisher = Label.new('Publisher', 'red')
    @item.label = publisher
    expect(@item.label.title).to eq('Publisher')
    expect(@item.label.color).to eq('red')
  end

  it 'Test for publish_date attribute' do
    expect(@item.publish_date).to eq(Date.parse('2010-01-01'))
  end

  it 'Test for archived attribute' do
    expect(@item.archived).to be false
    @item.move_to_archive
    expect(@item.archived).to be true
  end
end
