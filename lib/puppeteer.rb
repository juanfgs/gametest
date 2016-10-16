require_relative "./enemies/skeleton"
require 'chipmunk'
require 'pp'

# Class Player
# Inherits: Actor
# Represents the player actor
class Puppeteer 
  def self.spawn(type,world, options = {})
    case type
    when :skeleton_archer
      SkeletonArcher.new(world,options)
    end
  end
  
  
end
