require "json"

class World
  attr_reader :actors,:gravity,:friction, :horizon
  attr_accessor :viewport_height, :viewport_width
  def initialize
    @actors = []
    @gravitational_force = 0.85
    @gravity_acceleration = 0.0 #acceleration generated by gravitational force

  end

  def horizon
    @viewport_height - 140    
  end
  
  def add_actor(actor)
    @actors << actor
  end

  def gravity

    @actors.each {|actor|
      if actor.mass
        if actor.y >= horizon
          if actor.falling
            actor.vel_y = 0
          end
          @gravity_acceleration = 0
          actor.y = horizon
          actor.falling = false
          actor.mid_air = false
        elsif actor.vel_y.abs > 0.0 && actor.vel_y.abs < 1.0
          @gravity_acceleration = Gosu::offset_y(1, @gravitational_force)
          actor.vel_y -= @gravity_acceleration
        end
      end
    }

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