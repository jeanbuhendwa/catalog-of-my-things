class Label
  attr_accessor :id, :title, :color, :items

  def initialize(title, color)
    @id = rand(1..1000)
    @title = title
    @color = color
    @items = []
  end

  def item_add(item)
    @items << item
    item.label = self
  end

  def to_json
    {
      'id' => @id,
      'title' => @title,
      'color' => @color,
    }
  end
end
