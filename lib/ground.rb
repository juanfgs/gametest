require_relative "./actor.rb"
require "chipmunk"

class Ground < Actor
  attr_accessor :height
  
  def initialize
    @body = CP::Body.new_static()
    @width = 800.0
    @height = 600.0   
    shape_array = [CP::Vec2.new(0.0,0.0), CP::Vec2.new(0.0, @height), CP::Vec2.new(@width, @height), CP::Vec2.new(@width, 0)]
    @shape = CP::Shape::Poly.new(@body,shape_array,CP::Vec2.new(0,0) )
    @shape.collision_type = :ground
    @sprite = Gosu::Image.new("assets/images/ground.png")
  end
  
end
