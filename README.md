# Percolator

Simple particle-based physics engine

__Still in pre-alpha state, not production ready__

## Usage

This example will build a 50 lightweight and 50 heavyweight colliding particles in a bounded box (see more examples in `spec/percolator_spec.rb`):

```ruby
percolator = Percolator.new
collision  = Percolator::Behaviors::Collision.new
edge_bound = Percolator::Behaviors::EdgeBound.new(
  Percolator::Vector.new(0, 0), # min
  Percolator::Vector.new(WIDTH, HEIGHT) # max
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
```

To simulate and save the state of each step:

```ruby
frames = []
120.times do
  frames.push(percolator.to_h);
  percolator.step
end
json = JSON.generate(content)
```

## Testing

Run `bundle exec guard` to automatically run the tests. If you want to see the actual simulation, start a local server (by running something like `python -m SimpleHTTPServer 8000`) You can then open `http://localhost:8000/spec/preview.html` to see animated demos.

## Todo

- More behaviors
- Benchmarking
  - Algorithms
  - MRI vs Jruby vs Rubinius
  - GC optimization

## Credits

- Heavily influenced by [Soulwire's Coffee-Physics](http://github.com/soulwire/Coffee-Physics)

## License

Percolator is released under the [MIT License](http://opensource.org/licenses/MIT).
