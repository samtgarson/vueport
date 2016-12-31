# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vueport/version'

Gem::Specification.new do |spec|
  spec.name          = 'vueport'
  spec.version       = Vueport::VERSION
  spec.authors       = ['Sam Garson']
  spec.email         = ['samtgarson@gmail.com']

  spec.summary       = 'Single file components for Rails with Vue JS and Webpack'
  spec.description   = 'Use webpack and Vue js to get modern front end technology in your Rails app, including hotloading and single file components.'
  spec.homepage      = 'http://github.com/samtgarson/vueport'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.45.0'
  spec.add_development_dependency 'rspec-html-matchers', '~> 0.8.1'
  spec.add_development_dependency 'ammeter', '~> 1.1.4'

  spec.add_dependency 'rails', '>= 3.2.0'
  spec.add_dependency 'webpack-rails', '~> 0.9.9'
  spec.add_dependency 'httparty', '~> 0.14.0'

  spec.required_ruby_version = '>= 2.0.0'
end
