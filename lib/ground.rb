require_relative "./actor.rb"
require "chipmunk"

class Ground < Actor
  attr_accessor :height
  
  def initialize
    @body = CP::Body.new_static()
    @sprite = Gosu::Image.new("assets/images/ground.png")
    @width = 1200
    @height = 84
    @shape = CP::Shape::Poly.new(@body,vec_from_size,CP::Vec2.new(0,0) )
    
    @shape.collision_type = :ground

  end


  def draw
    tiles = (@width / @sprite.width) / 2
    (-tiles..tiles).each do |i|
      @sprite.draw_rot(@body.p.x + (@sprite.width * i ) ,@body.p.y    , 1, @body.a)
    end
  end

  
end
