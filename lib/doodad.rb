require_relative "./actor"

class BgDoodad < Actor

  def initialize(options = {})

    if options[:tileset]
      @sprite = Gosu::Image.new("assets/images/bg-doodad-#{options[:tileset]}.png")
    else
      @sprite = Gosu::Image.new("assets/images/bg-doodad-1.png")
    end

    @layer = if options[:layer] then options[:layer] else 1 end
    
      
#    moment = CP.moment_for_box(300, width, height)    
    @body = CP::Body.new(300,CP::INFINITY)
  end


  
  def draw
    @sprite.draw_rot(@body.p.x , @body.p.y  , @layer, @body.a)
  end
  
end
