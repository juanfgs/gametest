require_relative "./actor"
require "pp"

class Player < Actor
  attr_accessor :vel_y, :vel_x, :x, :y, :acc
  def initialize
    @sprite = Gosu::Image.new("assets/images/player.png")
    @background_image = Gosu::Image.new("assets/images/bg.png", :tileable => true)
    @x = @y = @vel_x = @vel_y =  0.0
    @acc = 0.5
    @mass = 50
  end

  def warp(x,y)
    @x,@y = x,y
  end


  def accelerate(angle)
    acc =  @mid_air ? @acc : 0.05
    
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
    
    @x = @x % 800

    
    @vel_x *= 0.95
    @vel_y *= 0.95
    
  end

  def jump
    @mid_air = true
    if @vel_y.abs < 2.0
      @vel_y += Gosu::offset_y(1, 2.5)
    else
      @falling = true
    end
  end  
  
  def draw
    @sprite.draw(@x,@y, 1 )
    @background_image.draw(0, 0, 0)
  end
end
