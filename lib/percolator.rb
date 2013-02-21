require 'json'

class Percolator
  attr_reader :particles

  def initialize
    @particles = []
  end

  def step(steps = 1)
    @particles.each do |p|
      #p.y += 1.0
    end
  end

  def add_particle(p)
    @particles.push(p)
  end

  def to_h
    {
      particles: @particles.map(&:to_h)
    }
  end
end

require 'percolator/vector'
require 'percolator/particle'
