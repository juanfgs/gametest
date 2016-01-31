require_relative "./actor"
require 'chipmunk'
require 'pp'

class Player < Actor
  attr_accessor :acc
  def initialize
    @sprite = Gosu::Image.new("assets/images/player.png")    

#    moment = CP.moment_for_box(10, width, height)    
    @body = CP::Body.new(10,CP::INFINITY)        

    @shape = CP::Shape::Poly.new(@body,vec_from_size,CP::Vec2.new(0,0) )
    @shape.collision_type = :player
    @shape.e = 0.0
    @shape.u = 1
    @shape.surface_v  = CP::Vec2.new(1.0,1.0)

    @body.w_limit = 0.5

  end

  def accelerate(angle)
     case angle
     when :right
       @body.v.x = 3 * 0.85
     when :left
       @body.v.x = -3 * 0.85
     end
  end

  def jump

    if @body.v.y.abs < 3
      @body.v.y = -3 * 0.85
    else
      @body.reset_forces
    end
  end  
  

end
