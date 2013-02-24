class Percolator
  class Collision
    def initialize(useMass = true)
      @pool = []
      # Delta between particle positions.
      @delta = Vector.new
    end

    def add_particle(p)
      @pool.push(p)
    end

    def apply(p1, dt, index)
      @pool[index...@pool.length].each do |p2|
        unless p1 == p2
          # Delta between particles positions
          dist = p1.pos.dist(p2.pos)
          radii = p1.radius + p2.radius


          if dist <= radii
            delta  = p1.pos.dup.sub(p2.pos)
            theta  = Math.atan2(delta.y, delta.x)
            sine   = Math.sin(theta)
            cosine = Math.cos(theta)

            # p2's position is relative to p1's
            # so you can use the vector between them (delta) as the
            # reference point in the rotation expressions.
            # temp_pos1 will initialize automatically
            # to (0,0), which is what you want
            # since p2 will rotate around p1
            temp_pos1 = Vector.new(0.0, 0.0)
            temp_pos2 = Vector.new(
              (cosine * delta.x) + (sine * delta.y),
              (cosine * delta.y) - (sine * delta.x)
            )

            # rotate temporary velocities
            temp_vel1 = Vector.new(
              (cosine * p1.vel.x) + sine * p1.vel.y,
              (cosine * p1.vel.y) - sine * p1.vel.x
            )
            temp_vel2 = Vector.new(
              (cosine * p2.vel.x) + sine * p2.vel.y,
              (cosine * p2.vel.y) - sine * p2.vel.x
            )

            # Now that velocities are rotated, you can use 1D
            # conservation of momentum equations to calculate 
            # the final velocity along the x-axis.

            rotated_vel1 = Vector.new(
              ((p1.mass - p2.mass) * temp_vel1.x + 2 * p2.mass * temp_vel2.x) / (p1.mass + p2.mass),
              temp_vel1.y
            )
            rotated_vel2 = Vector.new(
              ((p2.mass - p1.mass) * temp_vel2.x + 2 * p1.mass * temp_vel1.x) / (p1.mass + p2.mass),
              temp_vel2.y
            )

            # hack to avoid clumping
            temp_pos1.x += rotated_vel1.x
            temp_pos2.x += rotated_vel2.x

            # Rotate ball positions and velocities back.
            # Reverse signs in trig expressions to rotate
            # in the opposite direction

            # rotate balls
            p1_final = Vector.new(
              cosine * temp_pos1.x - sine * temp_pos1.y,
              cosine * temp_pos1.y + sine * temp_pos1.x,
            )
            p2_final = Vector.new(
              cosine * temp_pos2.x - sine * temp_pos2.y,
              cosine * temp_pos2.y + sine * temp_pos2.x,
            )

            # update balls to screen position
            #p2.pos.x = p1.pos.x + p2_final.x
            #p2.pos.y = p1.pos.y + p2_final.y
            #p1.pos.x = p1.pos.x + p2_final.x
            #p1.pos.y = p1.pos.y + p2_final.y

            # update velocities
            p1.vel.x = cosine * rotated_vel1.x - sine * rotated_vel1.y
            p1.vel.y = cosine * rotated_vel1.y + sine * rotated_vel1.x
            p2.vel.x = cosine * rotated_vel2.x - sine * rotated_vel2.y
            p2.vel.y = cosine * rotated_vel2.y + sine * rotated_vel2.x
          end
        end
      end
    end
  end
end
