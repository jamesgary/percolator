require 'json'

class Percolator
  attr_reader :particles

  def initialize(integrator = Integrators::Euler)
    @integrator = integrator
    @viscosity = 0.005
    @drag = 1.0 - @viscosity
    @precision = 4 # Iterations per step
    @dt = 1.0 / @precision

    @behaviors = [] # Global behaviors
    @particles = []
    @springs   = []
  end

  def step(steps = 1)
    steps.times do
      integrate
    end
  end

  def add_particle(p)
    @particles.push(p)
  end

  def add_behavior(behavior)
    @behaviors.push(behavior)
  end

  def to_h
    { particles: @particles.map(&:to_h) }
  end

  private

  def integrate
    @particles.each_with_index do |p, index|
      @behaviors.each { |b| b.apply(p, @dt, index) }
      p.update(@dt)
    end

    @integrator.integrate(@particles, @dt, @drag)

    # @springs.each do |s|
    #   s.apply()
    # end
  end
end

# core
require 'percolator/vector'
require 'percolator/particle'

# behaviors
require 'percolator/behaviors/collision'

# integrators
require 'percolator/integrators/euler'
