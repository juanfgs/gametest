require_relative "./actor"

class Block < Actor
  attr_accessor :x,:y
  def initialize
    @sprite = Gosu::Image.new("assets/images/tile.png")
    @height = 28
  end

  def place(x,y)
    @x,@y = x,y
  end
  
  def draw
    @sprite.draw(@x,@y, 1)
  end
  
end
