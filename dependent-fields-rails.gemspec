Gem::Specification.new do |s|
  s.name    = 'dependent-fields-rails'
  s.version = '0.1.0'
  s.author  = 'Lion Vollnhals'
  s.email   = 'lion@giantmonkey.de'
  s.summary = 'DependentFields makes it easy to hide or show dependent fields in forms based on select or checkbox values'
  s.files   = Dir["lib/assets/javascripts/*.js.coffee", "README.md", "MIT-LICENSE"]
  
  s.add_dependency 'coffee-rails'
end
