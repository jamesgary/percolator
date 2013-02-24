Gem::Specification.new do |s|
  s.name    = 'percolator'
  s.version = '0.0.1.prealpha'

  s.author   = 'James Gary'
  s.email    = 'mrjamesgary@gmail.com'
  s.summary  = 'Simple particle-based physics engine'
  s.homepage = 'http://github.com/jamesgary/percolator'
  s.license  = 'MIT'

  s.require_path = 'lib'
  s.files = Dir.glob('lib/**/*') + %w(README.md)

  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rb-fsevent'
end
