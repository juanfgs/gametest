class Actor
  attr_accessor :sprite, :x, :y, :angle, :mass, :falling, :mid_air, :height

  def width
    @sprite.width
  end

  def height
    @sprite.height
  end 
  
end
