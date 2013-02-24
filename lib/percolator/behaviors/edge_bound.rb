class Percolator
  class Behaviors
    class EdgeBound
      def initialize(min, max)
        @min = min
        @max = max
      end

      def apply(p, dt, index)
        if p.pos.x - p.radius < @min.x
          p.pos.x = @min.x + p.radius
          p.vel.x = p.vel.x.abs
        elsif p.pos.x + p.radius > @max.x
          p.pos.x = @max.x - p.radius
          p.vel.x = -1 * p.vel.x.abs
        end

        if p.pos.y - p.radius < @min.y
          p.pos.y = @min.y + p.radius
          p.vel.y = p.vel.y.abs
        elsif p.pos.y + p.radius > @max.y
          p.pos.y = @max.y - p.radius
          p.vel.y = -1 * p.vel.y.abs
        end
      end
    end
  end
end

