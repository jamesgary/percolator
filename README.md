Just port Coffee-Physics

```ruby
perc = Percolator.new(...)
particle = Percolator::Particle.new(...)
perc.add(particle)

perc.current_step => step_index
perc.step(number_of_steps_to_take)
perc.step_to(step_index)

perc.json_state

perc.collect_garbage
```

For testing:

rake showme

- generate json file for 'frames' of [bouncing, colliding, fast bullets, effects, etc]
- generate html file w/ canvas to point to json and animate/loop
