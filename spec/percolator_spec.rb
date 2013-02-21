require 'spec_helper'

describe Percolator do
  WIDTH  = 400.0
  HEIGHT = 300.0
  RESULTS_DIR = 'tmp/spec_data/'

  let(:percolator) { Percolator.new }

  it 'simulates static particles' do
    100.times do
      p = Percolator::Particle.new(
        x: rand(WIDTH),
        y: rand(HEIGHT),
      )
      percolator.add_particle(p)
    end
    particles = percolator.particles

    expect(particles.length).to eq 100
    particles.each do |p|
      expect(p.x).to be > 0
      expect(p.y).to be > 0
      expect(p.x).to be < WIDTH
      expect(p.y).to be < HEIGHT
    end

    write_to_file([percolator.to_h], 'static')
  end

  it 'simulates falling particles' do
    10.times do
      p = Percolator::Particle.new(
        x: rand(WIDTH),
        y: rand(HEIGHT),
      )
      percolator.add_particle(p)
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

  def write_to_file(content, filename)
    FileUtils.mkdir_p(RESULTS_DIR)
    File.open("#{ RESULTS_DIR }#{ filename }.json", 'w') { |f| f.write(JSON.generate(content)) }
  end
end
