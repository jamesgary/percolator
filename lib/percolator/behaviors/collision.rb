class Percolator
  class Collision
    def initialize(useMass = true)
      @pool = []
      # Delta between particle positions.
      @delta = Vector.new

      @temp_vel1    = Vector.new
      @temp_vel2    = Vector.new
      @rotated_vel1 = Vector.new
      @rotated_vel2 = Vector.new
    end

    def add_particle(p)
      @pool.push(p)
    end

    def apply(p1, dt, index)
      @pool[index...@pool.length].each do |p2|
        unless p1 == p2
          dist = p1.pos.dist(p2.pos)
          radii = p1.radius + p2.radius

          if dist <= radii
            # Heavily lifted from http://processing.org/learning/topics/circlecollision.html
            delta  = p1.pos.dup.sub(p2.pos)
            theta  = Math.atan2(delta.y, delta.x)
            sine   = Math.sin(theta)
            cosine = Math.cos(theta)

            # rotate temporary velocities
            @temp_vel1.set(
              (cosine * p1.vel.x) + sine * p1.vel.y,
              (cosine * p1.vel.y) - sine * p1.vel.x
            )
            @temp_vel2.set(
              (cosine * p2.vel.x) + sine * p2.vel.y,
              (cosine * p2.vel.y) - sine * p2.vel.x
            )

            # Now that velocities are rotated, you can use 1D
            # conservation of momentum equations to calculate
            # the final velocity along the x-axis.

            @rotated_vel1.set(
              ((p1.mass - p2.mass) * @temp_vel1.x + 2 * p2.mass * @temp_vel2.x) / (p1.mass + p2.mass),
              @temp_vel1.y
            )
            @rotated_vel2.set(
              ((p2.mass - p1.mass) * @temp_vel2.x + 2 * p1.mass * @temp_vel1.x) / (p1.mass + p2.mass),
              @temp_vel2.y
            )

            # update velocities
            p1.vel.set(
              cosine * @rotated_vel1.x - sine * @rotated_vel1.y,
              cosine * @rotated_vel1.y + sine * @rotated_vel1.x
            )
            p2.vel.set(
              cosine * @rotated_vel2.x - sine * @rotated_vel2.y,
              cosine * @rotated_vel2.y + sine * @rotated_vel2.x
            )

            # make sure they aren't overlapping anymore
            overlap = radii - dist
            mass_ratio = p1.mass / (p1.mass + p2.mass)
            p1.pos.x += cosine * overlap * mass_ratio
            p1.pos.y += sine   * overlap * mass_ratio
            p2.pos.x -= cosine * overlap * (1 - mass_ratio)
            p2.pos.y -= sine   * overlap * (1 - mass_ratio)
          end
        end
      end
    end
  end
end
