require "chipmunk"
require 'pp'

class World
  attr_reader :actors, :space

  def initialize
    @space = CP::Space.new()
    @actors = []

    handle_collisions
    
    @space.damping = 0.9
    @space.gravity.y = 0.5
  end


  def handle_collisions
    @space.add_collision_func(:player, :solid) do |player,solid|
      if player.body.p.y < solid.body.p.y
        player.object.grounded = true
      end
      true
    end
  end


  def inspect_body(shape)
    puts "Type:#{shape.collision_type}"     
    puts "X:#{shape.body.p.x} Y:#{shape.body.p.y}"    
    puts "vX:#{shape.body.v.x} vY:#{shape.body.v.y}"
    puts "fX:#{shape.body.f.x} fY:#{shape.body.f.y}"        
  end  
  
  def add_actor(actor, rogue = false)
    @actors << actor
    if rogue #adds static shape to have a rogue body
      @space.add_static_shape(actor.shape) 
    else
      @space.add_body(actor.body)      
      @space.add_shape(actor.shape)
    end
  end

  def show
    @actors.each { |actor|
      actor.draw
    }


  end

end
