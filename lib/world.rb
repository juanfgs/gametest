require "chipmunk"
require 'pp'

class World
  attr_reader :actors, :space

  def initialize
    @space = CP::Space.new()
    @actors = []
    @decal_expiry = 5
    handle_collisions
    
    @space.damping = 0.9
    @space.gravity.y = 0.9
  end


  def handle_collisions
    @space.add_collision_func(:player, :solid) do |player,solid|
      if player.body.p.y < solid.body.p.y
        player.object.grounded = true
      end
      true
    end


    @space.add_collision_func(:projectile, :solid) do |projectile, solid|
      projectile.body.i = CP::INFINITY
      projectile.body.activate
      remove = Proc.new { |space, projectile|
        space.remove_body(projectile.body)
        space.remove_shape(projectile.body.object.shape)
        projectile = nil
      }
      @space.add_post_step_callback( projectile, &remove)
    end 
  end


  def inspect_body(shape)
    puts "Type:#{shape.collision_type}"     
    puts "X:#{shape.body.p.x} Y:#{shape.body.p.y}"    
    puts "vX:#{shape.body.v.x} vY:#{shape.body.v.y}"
    puts "fX:#{shape.body.f.x} fY:#{shape.body.f.y}"        
  end  
  
  def add_actor(actor, options = {})
    
    @actors << actor
    unless options[:without_physics]
      if options[:rogue] #adds static shape to have a rogue body
        @space.add_static_shape(actor.shape) 
      else
        @space.add_body(actor.body)      
        @space.add_shape(actor.shape)
      end
    end
    @actors.length - 1
  end

  def cleanup_projectiles

    current = Time.now
    @actors.each do |actor|
                 
      if actor.is_a? Projectile
        puts (current - actor.created) 
        if (current - actor.created) > @decal_expiry
          @actors.delete_at(actor.actor_id)
        end 
      end
    end

  end
  
  def show
    
    @actors.each { |actor| actor.draw }
  end

end
