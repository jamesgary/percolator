require 'spec_helper'

describe Percolator do
  WIDTH  = 400.0
  HEIGHT = 300.0
  RESULTS_DIR = 'tmp/spec_data/'

  let(:percolator) { Percolator.new }

  it 'simulates static particles' do
    100.times do
      percolator.add_particle(Percolator::Particle.new(
        pos: Percolator::Vector.new(rand(WIDTH), rand(HEIGHT))
      ))
    end
    particles = percolator.particles

    expect(particles.length).to eq 100
    particles.each do |p|
      pos = p.pos
      expect(pos.x).to be > 0
      expect(pos.y).to be > 0
      expect(pos.x).to be < WIDTH
      expect(pos.y).to be < HEIGHT
    end

    write_to_file([percolator.to_h], 'static')
  end

  it 'simulates sliding particles' do
    speed_range = -10.0..10.0
    10.times do
      percolator.add_particle(Percolator::Particle.new(
        pos: Percolator::Vector.new(rand(WIDTH), rand(HEIGHT)),
        vel: Percolator::Vector.new(rand(speed_range), rand(speed_range))
      ))
    end

    frames = []
    120.times do
      frames.push(percolator.to_h);
      percolator.step
    end

    write_to_file(frames, 'falling')
  end
  #it 'simulates colliding particles'
  #it 'simulates colliding bouncing particles'

  private

  def rand(num)
    Random.rand(num)
  end

  def random_particle
    Percolator::Particle.new(
      pos: Percolator::Vector.new(rand(WIDTH), rand(HEIGHT))
    )
  end

  def write_to_file(content, filename)
    FileUtils.mkdir_p(RESULTS_DIR)
    File.open("#{ RESULTS_DIR }#{ filename }.json", 'w') { |f| f.write(JSON.generate(content)) }
  end
end
