require_relative '../item'
require_relative '../musicAlbum/music_album'

describe Item do
  before :each do
    @item = Item.new('2010-01-01')
  end

  it 'Test for Item instance' do
    expect(@item).to be_instance_of Item
  end

  it 'Test for genre attribute' do
    expect(@item.genre).to be_nil
    @item.genre = 'Fiction'
    expect(@item.genre).to eq('Fiction')
  end

  it 'Test for author attribute' do
    expect(@item.author).to be_nil
    @item.author = 'John Doe'
    expect(@item.author).to eq('John Doe')
  end

  it 'Test for source attribute' do
    expect(@item.source).to be_nil
    @item.source = 'Library'
    expect(@item.source).to eq('Library')
  end

  it 'Test for label attribute' do
    expect(@item.label).to be_nil
    @item.label = 'Publisher'
    expect(@item.label).to eq('Publisher')
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

describe MusicAlbum do
  before :each do
    @music_album = MusicAlbum.new('2020-02-02', on_spotify: true)
  end

  it 'Test for MusicAlbum instance' do
    expect(@music_album).to be_instance_of MusicAlbum
  end

  it 'Test for on_spotify attribute' do
    expect(@music_album.on_spotify).to be true
  end

  it 'Test for genre attribute' do
    expect(@music_album.genre).to be_nil
    @music_album.genre = 'Rock'
    expect(@music_album.genre).to eq('Rock')
  end
end
