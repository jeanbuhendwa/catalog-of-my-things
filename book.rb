require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(cover_state)
    super(publish_date)
    @id = rand(1..1000)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
