Gem::Specification.new do |s|
  s.name    = 'dependent-fields-rails'
  s.version = '0.4.2'
  s.author  = 'Lion Vollnhals'
  s.email   = 'lion@giantmonkey.de'
  s.summary = 'DependentFields makes it easy to hide or show dependent fields in forms based on select or checkbox values'
  s.homepage = 'https://github.com/vollnhals/dependent-fields-rails'
  s.files   = Dir["lib/*", "vendor/assets/javascripts/*.js.coffee", "README.md", "MIT-LICENSE"]

  s.add_dependency 'jquery-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency "railties", ">= 3.1"
end
