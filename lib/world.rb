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
    
    @space.add_collision_func(:player, :player) do |player,solid|
      if player.body.p.y < solid.body.p.y
        player.object.grounded = true
      end
      true
    end

    @space.add_collision_func(:projectile, :player) do |projectile, player|
      if projectile.body.object.launcher != player.body.object #check if the collision is not caused by the launcher
        player.object.take_damage!(projectile.body.object.damage)

        projectile.body.i = CP::INFINITY
        projectile.body.activate
        remove = Proc.new { |space, projectile|
          space.remove_body(projectile.body)
          space.remove_shape(projectile.body.object.shape)
          projectile = nil
        }
        @space.add_post_step_callback( projectile, &remove)
        projectile.body.object.delete!
      end
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
  
  def launch_projectile(actor)
    unless actor.cooldown?
      projectile = Projectile.new( actor )
      projectile.warp(actor.body.p.x,actor.body.p.y)
      projectile.actor_id = self.add_actor(projectile)
      projectile.launch(actor.direction)
      actor.use_ability
    end
  end

  def cleanup_projectiles

    current = Time.now
    @actors.each_with_index do |actor,idx|
                 
      if actor.is_a? Projectile
        if actor.deleted
          @actors.delete_at idx
        end
      elsif actor.kind_of? Enemy
        
        if actor.dead
          @actors.delete_at idx
        end

      end
    end

  end
  
  def show
    
    @actors.each { |actor| actor.draw }
  end

end
