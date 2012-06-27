Gem::Specification.new do |s|
  s.name        = 'cinch-yaml-score'
  s.version     = '1.0.0'
  s.summary     =
  s.description = 'A Cinch plugin to count +1, scores are saved in yaml file for persistence.'
  s.authors     = ['Michal Papis']
  s.email       = ['mpapis@gmail.com']
  s.homepage    = 'https://github.com/mpapis/cinch-yaml-score'
  s.files       = Dir['LICENSE', 'README.md', 'lib/**/*']
  s.required_ruby_version = '>= 1.9.1'
  s.add_dependency("cinch", "~> 2")
end
