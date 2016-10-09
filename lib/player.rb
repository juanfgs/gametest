require_relative "./actor"
require 'chipmunk'
require 'pp'

# Class Player
# Inherits: Actor
# Represents the player actor
class Player < Actor
  attr_accessor :acc, :projectile_type, :direction, :cooldown
  
  def initialize
    @sprite_right = Gosu::Image.new("assets/images/player/player-idle.png") #define idle animation facing left
    @sprite_left = Gosu::Image.new("assets/images/player/player-idle-left.png") #define idle animation facing right
    
    @sprite_anim_running = [ #defines running animation facing right
      Gosu::Image.new("assets/images/player/player-running1.png"),
      Gosu::Image.new("assets/images/player/player-running2.png"),
      Gosu::Image.new("assets/images/player/player-running3.png"),
      Gosu::Image.new("assets/images/player/player-running4.png"),
      Gosu::Image.new("assets/images/player/player-running5.png"),
      Gosu::Image.new("assets/images/player/player-running6.png"),
      Gosu::Image.new("assets/images/player/player-running7.png"),
      Gosu::Image.new("assets/images/player/player-running8.png"),
      Gosu::Image.new("assets/images/player/player-running9.png"),
      Gosu::Image.new("assets/images/player/player-running10.png"),
      Gosu::Image.new("assets/images/player/player-running11.png"),
      Gosu::Image.new("assets/images/player/player-running12.png")
                           ]
    @sprite_anim_running_left = [ #defines running animation facing left
      Gosu::Image.new("assets/images/player/player-running-left1.png"),
      Gosu::Image.new("assets/images/player/player-running-left2.png"),
      Gosu::Image.new("assets/images/player/player-running-left3.png"),
      Gosu::Image.new("assets/images/player/player-running-left4.png"),
      Gosu::Image.new("assets/images/player/player-running-left5.png"),
      Gosu::Image.new("assets/images/player/player-running-left6.png"),
      Gosu::Image.new("assets/images/player/player-running-left7.png"),
      Gosu::Image.new("assets/images/player/player-running-left8.png"),
      Gosu::Image.new("assets/images/player/player-running-left9.png"),
      Gosu::Image.new("assets/images/player/player-running-left10.png"),
      Gosu::Image.new("assets/images/player/player-running-left11.png"),
      Gosu::Image.new("assets/images/player/player-running-left12.png")

                                ]

    @sprite_anim_attack = [ #defines attack animation facing right
      Gosu::Image.new("assets/images/player/attack1.png"),
      Gosu::Image.new("assets/images/player/attack2.png"),
      Gosu::Image.new("assets/images/player/attack3.png"),
      Gosu::Image.new("assets/images/player/attack4.png"),
      Gosu::Image.new("assets/images/player/attack5.png")
                           ]
    @sprite_anim_attack_left = [ #defines attack animation facing left
      Gosu::Image.new("assets/images/player/attack-left1.png"),
      Gosu::Image.new("assets/images/player/attack-left2.png"),
      Gosu::Image.new("assets/images/player/attack-left3.png"),
      Gosu::Image.new("assets/images/player/attack-left4.png"),
      Gosu::Image.new("assets/images/player/attack-left5.png")
                           ]

    @cooldown = 0
    @cooldown_time = 20
    @projectile_type = "spear"
    @running = false #sets running status as false
    @sprite = @sprite_right #sets default sprite
    @direction = :right 
    @current_frame, @atk_current_frame = 0, 0; #restarts running and attack frame counter
    @body = CP::Body.new(10, CP::INFINITY)        
    @layer = 2
    @shape = CP::Shape::Poly.new(@body,vec_arbitrary_size(42,60),CP::Vec2.new(0,0) ) #defines shape for collision detection
    @shape.collision_type = :player
    @shape.e = 0.0
    @shape.u = 1
    @shape.surface_v  = CP::Vec2.new(1.0,1.0)
    @shape.object = self
    @body.w_limit = 0.5

  end

  # accelerate
  # @params int direction
  # accelerates towards an angle, currently accepts left or right as parameters
  def accelerate(direction)
    @current_frame = if @current_frame >= 11 then 0 else @current_frame end
    @direction = direction
     case direction
     when :right
       @sprite = @sprite_anim_running[@current_frame]
       @body.v.x = 3 * 0.85
     when :left
       @sprite = @sprite_anim_running_left[@current_frame]
       @body.v.x = -3 * 0.85
     end
     @current_frame += 1
  end

  # jump
  # @params nil
  # makes the actor jump, 
  def jump
    if @grounded
      @body.v.y = -20 * 0.95
      @grounded = false
    end
  end  

  # attack
  # @params nil
  # @returns nil
  # makes the actor attack, and sets the attack animation sprites
  def attack
    @attacking = true
    if @atk_current_frame <= 4
      if @direction == :left
        @sprite = @sprite_anim_attack_left[@atk_current_frame]
      else
        @sprite = @sprite_anim_attack[@atk_current_frame]
      end

      @atk_current_frame += 1
    else
      @atk_current_frame = 0
      @attacking = false
    end
  end

  
  # draw
  # overrides default draw method determines changes the sprite if the animation is idle to face
  # current player direction
  def draw
    @running = @body.v.x.abs >= 1

    unless @running or @attacking #set idle sprite unless they're running or attacking
      if @direction == :left
        @sprite = @sprite_left 
      else
        @sprite = @sprite_right
      end

    end
    super
  end

  def ability_cooldown
    if @cooldown <= @cooldown_time && @cooldown > 0
      @cooldown += 1
    elsif @cooldown >= @cooldown_time
      @cooldown = 0
    end
  end

  def cooldown?
    @cooldown != 0
  end

  def use_ability
    @cooldown += 1
  end
  
end
