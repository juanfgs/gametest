require_relative "./actor"
require 'chipmunk'
require 'pp'

class Player < Actor
  SPRITE_RIGHT = 0
  SPRITE_LEFT = 1
  
  attr_accessor :acc
  def initialize
    @sprites = Gosu::Image.load_tiles("assets/images/player.png", 32,72)
    @sprite = @sprites[SPRITE_RIGHT]
    pp @sprites
    @direction = :right
    
    @body = CP::Body.new(10, CP::INFINITY)        
    @layer = 2
    @shape = CP::Shape::Poly.new(@body,vec_from_size,CP::Vec2.new(0,0) )
    @shape.collision_type = :player
    @shape.e = 0.0
    @shape.u = 1
    @shape.surface_v  = CP::Vec2.new(1.0,1.0)
    @shape.object = self
    @body.w_limit = 0.5

  end


  def accelerate(angle)
    @direction = angle
     case angle
     when :right
       @body.v.x = 3 * 0.85
     when :left
       @body.v.x = -3 * 0.85
     end
  end

  def jump
    if @grounded
      @body.v.y = -20 * 0.95
      @grounded = false
    end
  end  


  def draw
    if @direction == :left
      @sprite = @sprites[SPRITE_LEFT]
    else
      @sprite = @sprites[SPRITE_RIGHT]
    end
    
    super
  end

end
