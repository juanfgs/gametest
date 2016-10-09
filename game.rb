require "gosu"
require_relative "./lib/player"
require_relative "./lib/projectile"
require_relative "./lib/crate"
require_relative "./lib/doodad"
require_relative "./lib/platform"
require_relative "./lib/world"
require_relative "./lib/ground"

class GameWindow < Gosu::Window
  
  def initialize
    super 1024, 768
    self.caption =  "Game test"

    @world = World.new()

    
    @player = Player.new
    @player.warp(200,120) #position the player
    @world.add_actor(@player)

        
    @player2 = Player.new
    @player2.warp(600,120) #position the player
    @world.add_actor(@player2)

    @ground = Platform.new(1400)
    @ground.warp(400,726) #position the ground
    @world.add_actor(@ground, :rogue => true)    

    @platform = Platform.new(256)
    @platform.warp(256,662)
    @world.add_actor(@platform, :rogue => true)


    
    @crate = Crate.new
    @crate.warp(640,128)
    @world.add_actor(@crate )


    @bush = BgDoodad.new( :tileset => 3, :layer => 1)
    @bush.warp(246,631)
    @world.add_actor(@bush, :without_physics => true)

    @bush2 = BgDoodad.new( :tileset => 3, :layer => 30)
    @bush2.warp(200,631)
    @world.add_actor(@bush2, :without_physics => true)
    
    @bush2 = BgDoodad.new( :tileset => 3, :layer => 30)
    @bush2.warp(280,631)
    @world.add_actor(@bush2, :without_physics => true)

    

    
    @background_image = Gosu::Image.new("assets/images/bg.png", :tileable => false)
  end

  def update
    #player 1
    if Gosu::button_down? Gosu::KbLeft
      @player.accelerate :left
    end
    
    if Gosu::button_down? Gosu::KbRight 
      @player.accelerate :right
    end

    if Gosu::button_down? Gosu::KbUp 
      @player.jump        
    end

    if Gosu::button_down? Gosu::KbZ
      @player.attack
    end
    
    if Gosu::button_down? Gosu::KbX
      launch_projectile(@player)
    end
   
    #Player 2
    
    if Gosu::button_down? Gosu::GpLeft 
      @player2.accelerate :left
    end
    
    if Gosu::button_down? Gosu::GpRight 
      @player2.accelerate :right
    end

    if Gosu::button_down? Gosu::GpUp
      @player2.jump        
    end

    if Gosu::button_down? Gosu::GpButton0
      @player2.attack
    end

    if Gosu::button_down? Gosu::GpButton1
       launch_projectile(@player2) 
    end

    @player.ability_cooldown
    @player2.ability_cooldown
    @world.space.step 1
  end

  def launch_projectile(player)
    unless player.cooldown?
      projectile = Projectile.new( player.projectile_type )
      projectile.warp(player.body.p.x,player.body.p.y)
      projectile.actor_id = @world.add_actor(projectile)
      projectile.launch(player.direction)
      player.use_ability
    end
  end

  def draw

    tiles_x = 2000 / @background_image.width
    tiles_y = 768 / @background_image.height
    tiles_x.times { |i|
      tiles_y.times {|j|
              @background_image.draw(i * @background_image.width, j * @background_image.height, 0)
      }

    }

    @world.show
  end
end


window = GameWindow.new

window.show
