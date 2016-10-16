require_relative "./player"
require_relative "./ai"
require 'chipmunk'
require 'pp'

class Enemy < Player

  def ai_process_step
    case @ai.current_turn_action
    when :left
      accelerate(:left)
    when :right
      accelerate(:right)
    when :jump
      jump
    when :attack
      attack
    when :launch_projectile
      @world.launch_projectile(self)
    end
  end
end
