class Percolator::Particle
  def initialize(params)
    @x      = params[:x] || 0
    @y      = params[:y] || 0
    @radius = params[:radius] || 1.0
    @mass   = params[:mass] || 1.0
  end

  def to_json
    {
      x: @x,
      y: @y
    }
  end
end
