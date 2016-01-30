require_relative "./actor"
require 'chipmunk'
require 'pp'

class Player < Actor
  attr_accessor :acc
  def initialize
    @width = 72.0
    @height = 72.0
    moment = CP.moment_for_box(100, @width, @height)    
    @body = CP::Body.new(100,moment)        


    shape_array = [CP::Vec2.new(0.0,@height), CP::Vec2.new(@width, @height), CP::Vec2.new(@width, 0.0), CP::Vec2.new(0.0, 0.0)]
    @shape = CP::Shape::Poly.new(@body,shape_array,CP::Vec2.new(0,0) )
    @shape.collision_type = :player
    @shape.e = 0.0
    @shape.u = 1
    @shape.surface_v  = CP::Vec2.new(1.0,1.0)
    @sprite = Gosu::Image.new("assets/images/player.png")
    @body.w_limit = 0.5

  end

  def accelerate(angle)
     case angle
     when :right
       @body.v.x = 3
     when :left
       @body.v.x = -3
     end
  end

  def jump
    pp @body.v.y.abs
    if @body.v.y.abs < 3
      @body.v.y = -3
    end
  end  
  

end
