require "gosu"
require_relative "./lib/player"
require_relative "./lib/crate"
require_relative "./lib/platform"
require_relative "./lib/world"
require_relative "./lib/ground"

class GameWindow < Gosu::Window
  
  def initialize
    super 1024, 768
    self.caption =  "Game test"

    @world = World.new()

    
    @player = Player.new
    @player.warp(200,200) #position the player
    @world.add_actor(@player)

    
    @ground = Ground.new
    @ground.warp(600,726) #position the ground
    @world.add_actor(@ground,true)    

    @platform = Platform.new(256,64)
    @platform.warp(600,564)
    @world.add_actor(@platform,true)    

    @platform = Platform.new(256,64)
    @platform.warp(500,650)
    @world.add_actor(@platform,true)    

    @crate = Crate.new
    @crate.warp(600,350)
    @world.add_actor(@crate)

    @crate = Crate.new 2
    @crate.warp(600,350)
    @world.add_actor(@crate)        
    
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

      @player.jump        
    

    end

    @world.space.step 1
  end

  def draw
    @world.show
    tiles_x = 1024 / @background_image.width
    tiles_y = 768 / @background_image.height
    tiles_x.times { |i|
      tiles_y.times {|j|
              @background_image.draw(i * @background_image.width, j * @background_image.height, 0)
      }

    }

  end
end


window = GameWindow.new

window.show
