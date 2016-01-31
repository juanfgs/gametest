require_relative "./actor"

class Block < Actor

  def initialize
    @sprite = Gosu::Image.new("assets/images/tile.png")
    
    
    @body = CP::Body.new(50,CP::INFINITY)


    @shape = CP::Shape::Poly.new(@body,vec_from_size,CP::Vec2.new(0,0) )    

    @shape.collision_type = :block
    @shape.e = 0.0
    @shape.u = 0.0015    
  end


  

  
end
