require_relative "./actor"
require "pp"

class Player < Actor
  attr_accessor :vel_y, :vel_x, :acc, :x,:y
  def initialize
    @sprite = Gosu::Image.new("assets/images/player.png")
    @height = 74
    @x = @y = @vel_x = @vel_y =  0.0

    @acc = 0.5
    @mass = 50
  end

  def warp(x,y)
    @x,@y = x,y
  end


  def accelerate(angle)
    acc =  @mid_air ? 0.2 : @acc
    
    case angle
    when :right
      @vel_x += Gosu::offset_x(90, acc)
    when :left
      @vel_x += Gosu::offset_x(-90, acc)
    end
    
  end
  
  def move
    @x += @vel_x
    @y += @vel_y

    
    @vel_x *= 0.95
    @vel_y *= 0.95
    
  end

  def jump
    @mid_air = true
    if @vel_y.abs < 2.0
      @vel_y += Gosu::offset_y(1, 3.5)
    else
      @falling = true
    end
  end  
  
  def draw
    @sprite.draw(@x,@y, 1 )

  end
end
