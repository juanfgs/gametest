require "chipmunk"
require 'pp'

class World
  attr_reader :actors,:gravity,:friction, :horizon, :space
  attr_accessor :viewport_height, :viewport_width
  def initialize
    @space = CP::Space.new()
    @actors = []

    # @space.add_collision_func(:player,:ground) do |player,ground|

    #    puts "player hit the ground"
    #  end
    

    @space.gravity.y = 0.5
  end

  def horizon
    @viewport_height - 140    
  end
  
  def add_actor(actor, static = false)
    @actors << actor
    if static
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
