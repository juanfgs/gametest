require_relative "./actor"

class Block < Actor

  def initialize
    @width = 32.0
    @height = 32.0
    moment = CP.moment_for_box(50, @width, @height)
    @body = CP::Body.new(50,moment)    
    shape_array = [CP::Vec2.new(0.0,@height), CP::Vec2.new(@width, @height), CP::Vec2.new(@width, 0.0), CP::Vec2.new(0.0, 0.0)]
    @shape = CP::Shape::Poly.new(@body,shape_array,CP::Vec2.new(0,0) )    
    @sprite = Gosu::Image.new("assets/images/tile.png")
    @shape.collision_type = :block
    @shape.e = 0.0
    @shape.u = 1    
  end


  

  
end
