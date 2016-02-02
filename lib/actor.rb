require 'chipmunk'

class Actor
  attr_accessor :sprite, :angle, :mass, :grounded, :layer
  attr_reader :shape, :body

  def vec_from_size
    @width = @width ? width : @sprite.width
    @height = @height ? height : @sprite.height
    half_width = @width / 2
    half_height = @height / 2
    
    [CP::Vec2.new(-half_width,-half_height), CP::Vec2.new(-half_width, half_height), CP::Vec2.new(half_width, half_height), CP::Vec2.new(half_width,-half_height)]

  end

  def width
    @width ? @width : @sprite.width 
  end

  def height
    @height ? @height: @sprite.height
  end  
  
  def draw
    @sprite.draw_rot(@body.p.x , @body.p.y  , @layer, @shape.body.a)
  end
  
  def mid_air
    @body.v.y.abs > 0 
  end
  
  def warp(x,y)
    @body.p.x = x
    @body.p.y = y
  end


   
  
end

class Numeric
  def gosu_angle
    self * 180.0 / Math::PI + 90
  end
end
