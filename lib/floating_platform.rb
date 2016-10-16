require_relative "./platform.rb"
require "chipmunk"

class FloatingPlatform < Platform

  def initialize(width, angle = nil)
    
    super(width,angle)
    @sprite_start = Gosu::Image.new("assets/images/floating_platform_left.png")
    @sprite = Gosu::Image.new("assets/images/floating_platform_middle.png")
    @sprite_end = Gosu::Image.new("assets/images/floating_platform_right.png")
  end
end
