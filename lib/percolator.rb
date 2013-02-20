class Percolator
  def initialize
    #@parti = World.new
  end

  def step(steps = 1)
  end

  def to_json
    {
      particles: []
    }
  end
end

require 'percolator/particle'
