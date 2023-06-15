require_relative 'item'

class Book < Item
  attr_accessor :id, :publisher, :cover_state

  def initialize(publisher, cover_state, publish_date = nil)
    super(publish_date)
    @id = rand(1..1000)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end

  def to_json
    {
      'publisher' => @publisher,
      'cover_state' => @cover_state,
      'publish_date' => @publish_date
    }
  end
  
end