require 'spec_helper'

describe Percolator do
  WIDTH  = 400.0
  HEIGHT = 300.0
  RESULTS_DIR = 'tmp/spec_data/'
  SPEED_RANGE = -10.0..10.0

  let(:percolator) { Percolator.new }

  it 'simulates static particles' do
    100.times do
      Percolator::Particle.new(
        radius: 10,
        pos: Percolator::Vector.new(rand(WIDTH), rand(HEIGHT))
      ).tap do |p|
        percolator.add_particle(p)
      end
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
    10.times do
      Percolator::Particle.new(
        radius: 10,
        pos: Percolator::Vector.new(rand(WIDTH), rand(HEIGHT)),
        vel: Percolator::Vector.new(rand(SPEED_RANGE), rand(SPEED_RANGE))
      ).tap do |p|
        percolator.add_particle(p)
      end
    end

    frames = []
    120.times do
      frames.push(percolator.to_h);
      percolator.step
    end

    write_to_file(frames, 'sliding')
  end

  it 'simulates colliding particles' do
    collision = Percolator::Behaviors::Collision.new
    50.times do
      Percolator::Particle.new(
        radius: 7,
        mass: 1.0,
        pos: Percolator::Vector.new(rand(WIDTH), rand(HEIGHT)),
        vel: Percolator::Vector.new(rand(SPEED_RANGE), rand(SPEED_RANGE))
      ).tap do |p|
        percolator.add_particle(p)
        collision.add_particle(p)
      end
    end
    50.times do
      Percolator::Particle.new(
        radius: 9,
        mass: 2.0,
        pos: Percolator::Vector.new(rand(WIDTH), rand(HEIGHT)),
        vel: Percolator::Vector.new(rand(SPEED_RANGE), rand(SPEED_RANGE))
      ).tap do |p|
        percolator.add_particle(p)
        collision.add_particle(p)
      end
    end

    percolator.add_behavior(collision)

    frames = []
    120.times do
      frames.push(percolator.to_h);
      percolator.step
    end

    write_to_file(frames, 'colliding')
  end

  it 'simulates bounded colliding particles' do
    collision = Percolator::Behaviors::Collision.new
    edge_bound = Percolator::Behaviors::EdgeBound.new(
      Percolator::Vector.new(0, 0),
      Percolator::Vector.new(WIDTH, HEIGHT)
    )
    50.times do
      Percolator::Particle.new(
        radius: 7,
        mass: 1.0,
        pos: Percolator::Vector.new(rand(WIDTH), rand(HEIGHT)),
        vel: Percolator::Vector.new(rand(SPEED_RANGE), rand(SPEED_RANGE))
      ).tap do |p|
        percolator.add_particle(p)
        collision.add_particle(p)
      end
    end
    50.times do
      Percolator::Particle.new(
        radius: 9,
        mass: 2.0,
        pos: Percolator::Vector.new(rand(WIDTH), rand(HEIGHT)),
        vel: Percolator::Vector.new(rand(SPEED_RANGE), rand(SPEED_RANGE))
      ).tap do |p|
        percolator.add_particle(p)
        collision.add_particle(p)
      end
    end

    percolator.add_behavior(collision)
    percolator.add_behavior(edge_bound)

    frames = []
    120.times do
      frames.push(percolator.to_h);
      percolator.step
    end

    write_to_file(frames, 'edgebound')
  end

  it 'simulates attracting particles' do
    attraction = Percolator::Behaviors::Attraction.new(target: Percolator::Vector.new(20, 20))
    collision  = Percolator::Behaviors::Collision.new
    edge_bound = Percolator::Behaviors::EdgeBound.new(
      Percolator::Vector.new(0, 0),
      Percolator::Vector.new(WIDTH, HEIGHT)
    )
    10.times do
      Percolator::Particle.new(
        radius: 10,
        pos: Percolator::Vector.new(rand(WIDTH), rand(HEIGHT)),
        vel: Percolator::Vector.new(rand(SPEED_RANGE), rand(SPEED_RANGE))
      ).tap do |p|
        percolator.add_particle(p)
        collision.add_particle(p)
      end
    end

    percolator.add_behavior(attraction)
    percolator.add_behavior(collision)
    percolator.add_behavior(edge_bound)

    frames = []
    120.times do
      frames.push(percolator.to_h);
      percolator.step
    end

    write_to_file(frames, 'attraction')
  end


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
