require 'chipmunk'

class Actor
  attr_accessor :sprite, :angle, :mass, :falling, :mid_air, :height
  attr_reader :shape, :body

  def vec_from_size
    half_width = @sprite.width / 2
    half_height = @sprite.height / 2
    
    [CP::Vec2.new(-half_width,-half_height), CP::Vec2.new(-half_width, half_height), CP::Vec2.new(half_width, half_height), CP::Vec2.new(half_width,-half_height)]
  end
  
  def width
    @sprite.width
  end

  def height
    @sprite.height
  end  
  
  def pos_y
    @body.p.y
  end

  def pos_x
    @body.p.x
  end


  def vel_x
    @body.v.x
  end  


  def vel_y
    @body.v.y
  end
  
  def width
    @sprite.width
  end

  def height
    @sprite.height
  end 

  def draw
    @sprite.draw_rot(@body.p.x , @body.p.y  , 1, @shape.body.a)
  end
  
  def gosu_angle
    self * 180.0 / Math::PI + 90
  end
  
  def warp(x,y)
    @body.p.x = x
    @body.p.y = y
  end
  
end
