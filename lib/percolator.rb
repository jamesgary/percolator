require 'json'

class Percolator
  def initialize
    @particles = []
  end

  def step(steps = 1)
  end

  def add_particle(p)
    @particles.push(p)
  end

  def to_json
    {
      particles: @particles.map(&:to_json)
    }
  end
end

require 'percolator/particle'
