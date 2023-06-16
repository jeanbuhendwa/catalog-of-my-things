require 'date'
class Item
  attr_accessor :publish_date
  attr_reader :archived, :author, :genre, :label

  def initialize(date)
    @id = rand(1..300)
    @publish_date = Date.parse(date)
    @archived = false
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  def author=(author)
    @author = author
    author.items.push(self) unless author.items.include?(self)
  end

  def genre=(genre)
    @genre = genre
    genre.items.push(self) unless genre.items.include?(self)
  end

  def label=(label)
    @label = label
    label.items.push(self) unless label.items.include?(self)
  end

  def can_be_archived?
    ten_years_ago = Date.today - (10 * 365)
    return true if @publish_date < ten_years_ago

    false
  end
end
