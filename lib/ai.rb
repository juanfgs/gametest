class AI
  
  def initialize(type, actor,world)
    @type = type
    @actor = actor
    @players = []
    @world = world
    @world.actors.each_with_index do |a_actor, idx|
      if a_actor.is_a? Player
        @players << a_actor
      end
    end
  end

  
  def current_turn_action
    @direction = :right
    
    if @actor.grounded && @actor.platform.nil? != true
      if @actor.body.p.x - 1 < @actor.platform.body.p.x && @direction == :left
        @direction = :right
      elsif @actor.body.p.x  + 1 > @actor.platform.body.p.x  
        @direction = :left
      end 
        
      @direction
    end
    
    # case @type
    # when :ranged
    #   players.each do |player|
    #    player.body.p.y >= @actor.body.p.y && (player.body.p.x - @actor.body.p.x).abs <= 120
    #    (player.body.p.x - @actor.body.p.x).abs 
    #    :launch_projectile
    #   
    #   if player.body.p.x - @actor.body.p.x <= 0
    #        break :left
    #      elsif player.body.p.x - @actor.body.p.x >= 0
    #        break :right
    #      end
         
    #    end
    # end
    
    
  end

end
