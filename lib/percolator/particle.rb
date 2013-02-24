class Percolator
  class Particle
    # @GUID = 0

    DEFAULTS = {
      mass: 1.0,
      radius: 1.0,
      fixed: false,
    }

    attr_reader :pos, :vel, :acc, :mass_inv, :radius, :mass

    def initialize(params)
      # Set a unique id.
      # @id = 'p' + Particle.GUID++
      full_params = DEFAULTS.merge(params)

      setMass   full_params[:mass]
      setRadius full_params[:radius]
      @fixed  = full_params[:fixed]
      @pos    = full_params[:pos] || Vector.new
      @vel    = full_params[:vel] || Vector.new

      @behaviors = []
      @acc = Vector.new
    end

    def moveTo(pos)
      @pos.become(pos)
    end

    def setMass(mass = 1.0)
      @mass = mass
      @mass_inv = 1.0 / @mass
    end

    def setRadius(radius = 1.0)
      @radius = radius
      @radiusSq = @radius * @radius
    end

    def fixed?
      !!@fixed
    end

    # Applies all behaviors to derive new force
    def update(dt)
      unless @fixed
        @behaviors.each do |behavior|
          behavior.affect(self, dt, index)
        end
      end
    end

    def to_h
      {
        pos: @pos.to_h,
        vel: @vel.to_h,
        radius: @radius,
        mass: @mass,
      }
    end
  end
end
