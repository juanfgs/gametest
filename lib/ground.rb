require_relative "./actor.rb"
require "chipmunk"

class Ground < Actor
  attr_accessor :height
  
  def initialize
    @body = CP::Body.new_static()
    @sprite = Gosu::Image.new("assets/images/ground.png")    
    @shape = CP::Shape::Poly.new(@body,vec_from_size,CP::Vec2.new(0,0) )
    
    @shape.collision_type = :ground

  end

   # def draw
   #   puts "X:#{@body.p.x} Y:#{@body.p.y}\n"
   #   @sprite.draw_rot(@body.p.x  ,@body.p.y   , 1, @body.a)
   # end
  
end
