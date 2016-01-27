require "gosu"
require "pp"
require_relative "./lib/player"
require_relative "./lib/block"
require_relative "./lib/world"

class GameWindow < Gosu::Window
  
  def initialize
    super 800, 600
    self.caption =  "Game test"
 
    @world = World.new()
    @world.viewport_height = self.height
    @world.viewport_width = self.width
    
    @player = Player.new
    @player.warp(200,@world.horizon )
    @world.add_actor(@player)    

    @block = Block.new
    @block.place(300,@world.horizon + @block.height)
    @world.add_actor(@block)

    @background_image = Gosu::Image.new("assets/images/bg.png", :tileable => true)
    
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
    
    @world.gravity
#    @world.collision(@player)
    @player.move    
  end

  def draw
    @world.show
    @background_image.draw(0, 0, 0)    
  end
end


window = GameWindow.new

window.show
