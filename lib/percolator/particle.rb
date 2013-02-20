class Percolator::Particle
  def initialize(params)
    @radius = params[:radius]
    @mass = params[:mass] || 1.0
  end
end
