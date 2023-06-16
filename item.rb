require 'date'
class Item
  attr_accessor :genre, :author, :source, :label, :publish_date
  attr_reader :archived

  def initialize(date)
    @id = rand(1..300)
    @publish_date = Date.parse(date)
    @archived = false
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  def can_be_archived?
    ten_years_ago = Date.today - (10 * 365)
    return true if @publish_date < ten_years_ago

    false
  end
end
