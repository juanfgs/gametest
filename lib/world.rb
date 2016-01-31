require "chipmunk"
require 'pp'

class World
  attr_reader :actors, :space

  def initialize
    @space = CP::Space.new()
    @actors = []

    @space.damping = 0.9
    @space.gravity.y = 0.5
  end

  def horizon
    @viewport_height - 140    
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

  def from_file(file)
    @file = File.open(file)
    world_data_str = file.read
    @world_data =JSON.parse(world_data_str)

    @world_data.each { |actor| add_actor(actor)}


  end

  
end
