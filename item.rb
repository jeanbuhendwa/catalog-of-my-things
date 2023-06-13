require 'date'
class Item
  attr_accessor :genre, :author, :source, :label
  attr_reader :publish_date, :archived

  def initialize(date)
    @id = rand(1..300)
    @publish_date = Date.parse(date)
    @archived = false
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  private

  def can_be_archived?
    ten_years_ago = Date.today - (10 * 365)
    return true if @publish_date < ten_years_ago

    false
  end
end
