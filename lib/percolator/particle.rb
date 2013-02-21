class Percolator
  class Particle
    # @GUID = 0

    DEFAULTS = {
      mass: 1.0,
      radius: 1.0,
      fixed: false,
    }

    attr_reader :pos

    def initialize(params)
      # Set a unique id.
      # @id = 'p' + Particle.GUID++
      full_params = DEFAULTS.merge(params)

      setMass   full_params[:mass]
      setRadius full_params[:radius]
      @fixed  = full_params[:fixed]
      @pos    = full_params[:pos] || Vector.new
      @vel    = full_params[:vel] || Vector.new

      @behaviours = []
      @acc = Vector.new
      @old = {
        pos: Vector.new,
        vel: Vector.new,
        acc: Vector.new,
      }
    end

    def moveTo(pos)
      @pos.copy(pos)
      @old.pos.copy(pos)
    end

    def setMass(mass = 1.0)
      @mass = mass
      @massInv = 1.0 / @mass
    end

    def setRadius(radius = 1.0)
      @radius = radius
      @radiusSq = @radius * @radius
    end

    # Applies all behaviors to derive new force
    def update(dt, index)
      unless @fixed
        @behaviors.each do |behavior|
          behavior.modify(self, dt, index)
        end
      end
    end

    def to_h
      {
        pos: @pos.to_h,
        vel: @vel.to_h,
      }
    end
  end
end
