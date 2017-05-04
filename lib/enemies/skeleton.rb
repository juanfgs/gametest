require_relative '../enemy'

class SkeletonArcher < Enemy
  #Override initializer, enemies must know the world in order to provide the AI enough information to act
  def initialize(world,options)
    super(options)
    @world = world
    @ai = AI.new(:ranged,self, world)
    @scale_x = 1.0
    @scale_y = 1.0
    @sprite_right = Gosu::Image.new("assets/images/enemies/skeleton-archer/archer.png", :retro => true) 
  end
  
end
