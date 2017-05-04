require_relative "./player"
require_relative "./ai"
require 'chipmunk'
require 'pp'

class Enemy < Player
  attr_reader :ai_sensor
  def initialize(options)
    super(options)
    @ai_sensor = generate_sensor() #generates sensors left and right of the enemy in order to preeptively detect collisions
  end

  def generate_sensor()
    sensor = CP::Shape::Poly.new(@body,vec_arbitrary_size(60,80),CP::Vec2.new(0,0) ) #defines shape for collision detection
    sensor.sensor = true
    sensor.object = self
    sensor  
  end
  
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
