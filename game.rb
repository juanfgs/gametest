require "gosu"
require_relative "./lib/player"
require_relative "./lib/block"
require_relative "./lib/world"
require_relative "./lib/ground"

class GameWindow < Gosu::Window
  
  def initialize
    super 800, 600
    self.caption =  "Game test"

    @world = World.new()

    
    @player = Player.new
    @player.warp(200,200) #position the player
    @world.add_actor(@player)

    
    @ground = Ground.new
    @ground.warp(200,558) #position the ground
    @world.add_actor(@ground,true)    


    15.times {
       block = Block.new
       block.warp(400,380) #position a block
       @world.add_actor(block)
    }

    8.times {
       block = Block.new
       block.warp(400,280) #position a block
       @world.add_actor(block)
     }    
    
    6.times {
       block = Block.new
       block.warp(400,180) #position a block
       @world.add_actor(block)
     }


    4.times {
       block = Block.new
       block.warp(400,80) #position a block
       @world.add_actor(block)
    }

    2.times {
       block = Block.new
       block.warp(400,40) #position a block
       @world.add_actor(block)
     }        
    

    
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
      @player.body.reset_forces
      @player.jump
    end
    pp @player.body.p.y
    @world.space.step 1
  end

  def draw
    @world.show
    @background_image.draw(0, 0, 0)    
  end
end


window = GameWindow.new

window.show
