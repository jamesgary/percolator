class Percolator
  class Behaviors
    class Attraction
      attr_accessor :target, :strength

      def initialize(params)
        @target =    params[:target]   || Vector.new
        @strength =  params[:strength] || 10.0
        @radius =    params[:radius]   || 500.0
        @radius_sq = @radius * @radius
        @delta = Vector.new
      end

      def radius= (radius)
        @radius = radius
        @radius_sq = radius * radius
      end

      def apply(p, dt, index)
        # Vector pointing from particle to target
        @delta.become(@target).sub(p.pos)

        # Squared distance to target
        dist_sq = @delta.magSq

        # Limit force to behaviour radius
        if dist_sq < @radius_sq && dist_sq > 0.000001
          # Calculate force vector
          @delta.norm.scale(1.0 - (dist_sq / @radius_sq))

          # Apply force
          p.acc.add(@delta.scale(@strength))
        end
      end
    end
  end
end
