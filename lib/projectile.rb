require_relative "./actor"
require "chipmunk"

class Projectile < Actor
  attr_accessor :acc, :actor_id, :created, :damage, :launcher, :deleted
  

  #initialize
  # @param spriteset string: set that will represent the projectile
  # @param options = {}
  #        
  #
  def initialize( launcher)
    @damage = launcher.projectile_damage
    @spriteset = launcher.projectile_type
    @launcher = launcher
    @deleted = false
    @sprite_anim_downwards = Gosu::Image.new("assets/images/projectiles/#{@spriteset}/horizontal-right.png")
    @sprite_anim_downwards_left = Gosu::Image.new("assets/images/projectiles/#{@spriteset}/horizontal-left.png")
    @actor_id = 0
    @sprite = @sprite_anim_downwards #sets default sprite
    @direction = :right
    @current_frame, @atk_current_frame = 0, 0; #restarts running and attack frame counter
    @body = CP::Body.new(15, 15)        
    @layer = 2
    @shape = CP::Shape::Poly.new(@body, vec_arbitrary_size(4,6),CP::Vec2.new(5,6) )
    @shape.collision_type = :projectile
    @shape.e = 0.1
    @shape.u = 1
    #       @shape.surface_v  = CP::Vec2.new(0.0,0.0)
    @body.object = self
    @body.w_limit = 0.2
    @created = Time.now
  end
  
  
  def launch(direction)
    case direction
    when :right
      @sprite = @sprite_anim_downwards
      @body.a = -0.5
      @body.t = 90 
      @body.v.x = 30 * 0.85
      @body.v.y = -8 * 0.85
      
    when :left
      @sprite = @sprite_anim_downwards_left
      
      @body.a = -0.5
      @body.t = 90 
      @body.v.x = -30 * 0.85
      @body.v.y = -8 * 0.85
      
      end
  end

  def delete!
    @deleted = true
  end

  def draw
    unless @deleted
      super
    end
  end
  
end
