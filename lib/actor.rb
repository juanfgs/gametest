require 'chipmunk'

# Class Actor
# abstract Actor
# This class contains a handful of methods useful to render and calculate shapes for game actors

class Actor
  attr_accessor :sprite, :angle, :mass, :grounded, :layer
  attr_reader :shape, :body


  # Obtain CP::Vec2 array from sprite size
  # vec_from_size()
  # @return []CP::Vec2
  def vec_from_size
    @width = @width ? width : @sprite.width
    @height = @height ? height : @sprite.height
    half_width = @width / 2
    half_height = @height / 2
    
    [CP::Vec2.new(-half_width,-half_height), CP::Vec2.new(-half_width, half_height), CP::Vec2.new(half_width, half_height), CP::Vec2.new(half_width,-half_height)]

  end
  
  # Obtain CP::Vec2 array from given arbitrary size
  # TODO: use offset from bottom_left or right
  # vec_arbitrary_size()
  # @return []CP::Vec2
  def vec_arbitrary_size(width,height)
    @width =  width 
    @height =  height 
    half_width = @width / 2
    half_height = @height / 2
    
    [CP::Vec2.new(-half_width,-half_height), CP::Vec2.new(-half_width, half_height), CP::Vec2.new(half_width, half_height), CP::Vec2.new(half_width,-half_height)]

  end

  # gets width from sprite width
  # width()
  # @return Integer
  def width
    @width ? @width : @sprite.width 
  end

  # gets height from sprite height
  # height()
  # @return Integer
  def height
    @height ? @height: @sprite.height
  end  

  # implements a basic draw method for common Chipmunk managed actors
  # feel free to override if need to represent not physically simulated actors
  def draw
    @sprite.draw_rot(@body.p.x , @body.p.y  , @layer, @shape.body.a)
  end

  # determines if the body is mid air
  def mid_air
    @body.v.y.abs > 0 
  end

  # positions the body 
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
