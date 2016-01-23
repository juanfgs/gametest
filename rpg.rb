require "gosu"
require_relative "./lib/player"
class GameWindow < Gosu::Window
  attr_accessor :gravity
  def initialize
    super 800, 600
    self.caption =  "Game test"
    @horizon = self.height - 140
    @player = Player.new
    @player.warp(200,self.height - 72)
    @gravity = 0.0
    
  end

  def update

    if Gosu::button_down? Gosu::KbLeft #or Gosu::button_down? Gosu::GpLeft then
      @player.accelerate :left

     end
    if Gosu::button_down? Gosu::KbRight #or Gosu::button_down? Gosu::GpRight then
      @player.accelerate :right
    end

    if Gosu::button_down? Gosu::KbUp #or Gosu::button_down? Gosu::GpRight then
      if !@player.falling
        @player.jump
      end
    end

    if @player.y >= @horizon
      @gravity = 0
      @player.y = @horizon
      @player.falling = false
      @player.mid_air = false
    elsif @player.vel_y.abs > 0.0 && @player.vel_y.abs < 1.0
      @gravity = Gosu::offset_y(1, 0.85)
      @player.vel_y -= @gravity
    end

    @player.move
    
  end

  def draw
    @player.draw
  end
end


window = GameWindow.new

window.show
