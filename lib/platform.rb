require_relative "./actor.rb"
require "chipmunk"

class Platform < Actor
  attr_accessor :height
  
  def initialize(width,angle = nil)
    @body = CP::Body.new_static()
    @width = width
    @height = 17
    @sprite_start = Gosu::Image.new("assets/images/platform_start.png")
    @sprite = Gosu::Image.new("assets/images/platform_body.png")
    @sprite_end = Gosu::Image.new("assets/images/platform_end.png")

    @shape = CP::Shape::Poly.new(@body,vec_from_size,CP::Vec2.new(0,0) )

    if angle
      @body.a = angle
    end
    
    @shape.collision_type = :solid

  end

  def draw
     tiles = (@width / @sprite.width) / 2 
     (-tiles..tiles).each do |i|
       if i == -tiles
         @sprite_start.draw_rot(@body.p.x + (@sprite.width  * i  ) + 32 ,@body.p.y + 24    , 1, @body.a)
       elsif i > -tiles && i < tiles -1
         @sprite.draw_rot(@body.p.x + (@sprite.width * i ) + 32  ,@body.p.y + 24, 1, @body.a)
       elsif i == tiles -1
         @sprite_end.draw_rot(@body.p.x + (@sprite.width * i ) + 32 ,@body.p.y + 24  , 1, @body.a)
       end
     end
   end
  
end
