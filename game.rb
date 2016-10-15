require "gosu"
require_relative "./lib/player"
require_relative "./lib/enemy"
require_relative "./lib/projectile"
require_relative "./lib/crate"
require_relative "./lib/doodad"
require_relative "./lib/platform"
require_relative "./lib/floating_platform"
require_relative "./lib/world"
require_relative "./lib/ground"
require_relative "./lib/puppeteer"

class GameWindow < Gosu::Window
  
  def initialize
    super 1024, 768
    self.caption =  "Game test"

    @world = World.new()

    
    @player = Player.new :hit_points => 6
    @player.warp(200,120) #position the player
    @world.add_actor(@player)

        
    @player2 = Player.new :hit_points => 6
    @player2.warp(600,120) #position the player
    @world.add_actor(@player2)

    @enemy = Puppeteer.spawn(:skeleton_archer, @world,:hit_points => 1 )
    @enemy.warp(300,520) #position the player
    @world.add_actor(@enemy)

    
    @ground = Platform.new(1400)
    @ground.warp(400,726) #position the ground
    @world.add_actor(@ground, :rogue => true)    

    @platform = Platform.new(256)
    @platform.warp(256,662)
    @world.add_actor(@platform, :rogue => true)

    @platform = Platform.new(128)
    @platform.warp(296,598)
    @world.add_actor(@platform, :rogue => true)

    @platform = Platform.new(256)
    @platform.warp(626,662)
    @world.add_actor(@platform, :rogue => true)

    @platform = Platform.new(128)
    @platform.warp(566,598)
    @world.add_actor(@platform, :rogue => true)



    @platform = FloatingPlatform.new(176)
    @platform.warp(356,462)
    @world.add_actor(@platform, :rogue => true)

    @platform = FloatingPlatform.new(176)
    @platform.warp(756,562)
    @world.add_actor(@platform, :rogue => true)


    
    @platform = FloatingPlatform.new(176)
    @platform.warp(656,362)
    @world.add_actor(@platform, :rogue => true)

    @platform = FloatingPlatform.new(176)
    @platform.warp(156,362)
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
      @world.launch_projectile(@player)
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
       @world.launch_projectile(@player2) 
    end

    @world.actors.each_with_index  do |act,idx|
      if act.kind_of? Player
        act.ability_cooldown
        act.damage_cooldown
      end
      if act.kind_of? Enemy
        if act.dead 
          @world.remove_actor idx
        end
      end
        
    end
    
    @world.actors.each { |act| if act.is_a? Enemy then act.ai_process_step end }
    @world.space.step 1
  end
  

  def draw
    draw_hud

    tiles_x = 2000 / @background_image.width
    tiles_y = 768 / @background_image.height
    tiles_x.times { |i|
      tiles_y.times {|j|
              @background_image.draw(i * @background_image.width, j * @background_image.height, 0)
      }

    }

    @world.show
  end

  def draw_hud
    unless @player.dead
      @player1_hud = Gosu::Image.new("assets/images/HUD/#{@player.hit_points.ceil}.png")
      @player1_hud.draw(20 , 20  , 10)
    end

    unless @player2.dead
      @player2_hud = Gosu::Image.new("assets/images/HUD/#{@player2.hit_points.ceil}.png")
      @player2_hud.draw(960 , 20  , 10)
    end
  end
  
end


window = GameWindow.new

window.show
