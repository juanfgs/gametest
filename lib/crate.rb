require_relative "./actor"

class Crate < Actor

  def initialize
    @sprite = Gosu::Image.new("assets/images/crate.png")

#    moment = CP.moment_for_box(300, width, height)    
    @body = CP::Body.new(300,CP::INFINITY)

    @shape = CP::Shape::Poly.new(@body,vec_from_size,CP::Vec2.new(0,0) )    

    @shape.collision_type = :block
    @shape.e = 0.0
    @shape.u = 0.0015    
  end


  

  
end
