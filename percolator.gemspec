Gem::Specification.new do |s|
  s.name               = 'percolator'
  s.version            = '0.0.1'

  s.author = 'James Gary'
  s.email = 'mrjamesgary@gmail.com'
  s.summary = 'Simple particle-based physics engine'

  s.require_path = 'lib'
  s.files = Dir.glob('lib/**/*')# + %w(LICENSE README.markdown Rakefile)

  s.add_development_dependency 'rspec', '~> 2.0'
end
