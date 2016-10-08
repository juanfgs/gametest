require_relative "./actor"
require 'chipmunk'
require 'pp'

class Player < Actor
  SPRITE_RIGHT = 0
  SPRITE_LEFT = 1
  
  attr_accessor :acc
  def initialize
    @sprite_right = Gosu::Image.new("assets/images/player-idle.png")
    @sprite_left = Gosu::Image.new("assets/images/player-idle-left.png")
    @sprite_anim_running = [ Gosu::Image.new("assets/images/player-running1.png"), Gosu::Image.new("assets/images/player-running2.png"), Gosu::Image.new("assets/images/player-running3.png"),
                             Gosu::Image.new("assets/images/player-running4.png"),  Gosu::Image.new("assets/images/player-running5.png"), Gosu::Image.new("assets/images/player-running6.png"),
                             Gosu::Image.new("assets/images/player-running7.png"), Gosu::Image.new("assets/images/player-running8.png"), Gosu::Image.new("assets/images/player-running9.png"),
                             Gosu::Image.new("assets/images/player-running10.png"),  Gosu::Image.new("assets/images/player-running11.png"), Gosu::Image.new("assets/images/player-running12.png")

                           ]
    @sprite_anim_running_left = [ Gosu::Image.new("assets/images/player-running-left1.png"), Gosu::Image.new("assets/images/player-running-left2.png"), Gosu::Image.new("assets/images/player-running-left3.png"),
                                  Gosu::Image.new("assets/images/player-running-left4.png"),  Gosu::Image.new("assets/images/player-running-left5.png"), Gosu::Image.new("assets/images/player-running-left6.png"),
                                   Gosu::Image.new("assets/images/player-running-left7.png"), Gosu::Image.new("assets/images/player-running-left8.png"), Gosu::Image.new("assets/images/player-running-left9.png"),
                             Gosu::Image.new("assets/images/player-running-left10.png"),  Gosu::Image.new("assets/images/player-running-left11.png"), Gosu::Image.new("assets/images/player-running-left12.png")

                                ]

    @sprite_anim_attack = [
      Gosu::Image.new("assets/images/player/attack1.png"),
      Gosu::Image.new("assets/images/player/attack2.png"),
      Gosu::Image.new("assets/images/player/attack3.png"),
      Gosu::Image.new("assets/images/player/attack4.png"),
      Gosu::Image.new("assets/images/player/attack5.png")
                           ]
    @sprite_anim_attack_left = [
      Gosu::Image.new("assets/images/player/attack-left1.png"),
      Gosu::Image.new("assets/images/player/attack-left2.png"),
      Gosu::Image.new("assets/images/player/attack-left3.png"),
      Gosu::Image.new("assets/images/player/attack-left4.png"),
      Gosu::Image.new("assets/images/player/attack-left5.png")
                           ]


    
    @running = false
    @sprite = @sprite_right
    @direction = :right
    @current_frame, @atk_current_frame = 0, 0;
    @body = CP::Body.new(10, CP::INFINITY)        
    @layer = 2
    @shape = CP::Shape::Poly.new(@body,vec_from_size,CP::Vec2.new(0,0) )
    @shape.collision_type = :player
    @shape.e = 0.0
    @shape.u = 1
    @shape.surface_v  = CP::Vec2.new(1.0,1.0)
    @shape.object = self
    @body.w_limit = 0.5

  end


  def accelerate(angle)
    @current_frame = if @current_frame >= 11 then 0 else @current_frame end
    @direction = angle
     case angle
     when :right
       @sprite = @sprite_anim_running[@current_frame]
       @body.v.x = 3 * 0.85
     when :left
       @sprite = @sprite_anim_running_left[@current_frame]
       @body.v.x = -3 * 0.85
     end
     @current_frame += 1
  end

  def jump
    if @grounded
      
      @body.v.y = -20 * 0.95
      @grounded = false
    end
  end  

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

end
