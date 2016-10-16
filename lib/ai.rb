class AI
  
  def initialize(type, actor,world)
    @type = type
    @actor = actor
    @players = []
    @world = world
    @world.actors.each_with_index do |actor, idx|
      if actor.is_a? Player
        @players << actor
      end
    end
  end

  
  def current_turn_action
    case @type
    when :ranged
      @players.each do |player|
        if player.body.p.y >= @actor.body.p.y && (player.body.p.x - @actor.body.p.x).abs <= 120
          puts (player.body.p.x - @actor.body.p.x).abs 
          break :launch_projectile
        end

        if player.body.p.x - @actor.body.p.x <= 0
          break :left
        elsif player.body.p.x - @actor.body.p.x >= 0
          break :right
        end
         
      end
    end
    
    
  end

end
