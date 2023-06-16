require_relative '../item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(publish_date, multiplayer, last_played_at)
    super(publish_date)
    @multiplayer = multiplayer
    @last_played_at = Date.parse(last_played_at)
  end

  def can_be_archived?
    two_years_ago = Date.today - (2 * 365)

    return true if super && (@last_played_at < two_years_ago)

    false
  end
end
