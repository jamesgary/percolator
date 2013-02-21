class Percolator
  module Integrators
    class Euler
      # x += (v * dt) + (a * 0.5 * dt * dt)
      # v += a * dt
      def self.integrate(particles, delta, drag)
        delta_squared = delta * delta
        momentum = Vector.new
        acc = Vector.new

        particles.reject { |p| p.fixed? }.each do |p|
          p.acc.scale(p.mass_inv) # F = ma
          momentum.become(p.vel)
          acc.become(p.acc)

          p.pos.
            add(momentum.scale(delta)).
            add(acc.scale(0.5 * delta_squared))

          p.vel.add(p.acc.scale(delta))
          p.vel.scale(drag) # Apply friction

          p.acc.clear
        end
      end
    end
  end
end
