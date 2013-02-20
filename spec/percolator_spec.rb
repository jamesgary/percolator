require 'spec_helper'

describe Percolator do
  WIDTH  = 400.0
  HEIGHT = 300.0
  RESULTS_DIR = 'tmp/spec_data/'

  let(:percolator) { Percolator.new }

  it 'simulates static particles' do
    10.times do
      p = Percolator::Particle.new(
        x: rand(WIDTH),
        y: rand(HEIGHT),
      )
      percolator.add_particle(p)
    end

    json = percolator.to_json
    particles = json[:particles]

    expect(particles.length).to eq 10
    particles.each do |p|
      expect(p[:x]).to be > 0
      expect(p[:y]).to be > 0
      expect(p[:x]).to be < WIDTH
      expect(p[:y]).to be < HEIGHT
    end

    write_to_file(json, 'static')
  end

  #it 'simulates bouncing particles'
  #it 'simulates colliding particles'
  #it 'simulates colliding bouncing particles'

  private

  def rand(num)
    Random.rand(num)
  end

  def write_to_file(content, filename)
    FileUtils.mkdir_p(RESULTS_DIR)
    File.open("#{ RESULTS_DIR }#{ filename }.json", 'w') { |f| f.write(content) }
  end
end
