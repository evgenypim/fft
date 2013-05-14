# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'fft/version'

Gem::Specification.new do |s|
  s.name          = "fft"
  s.version       = Fft::VERSION
  s.authors       = ["Evgeny Pim"]
  s.email         = ["evgeny.pim@gmail.com"]
  s.summary       = 'yet another fft realization'
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'gnuplot'

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'yard-tomdoc'
  s.add_development_dependency 'redcarpet'
  s.add_development_dependency "rspec-core", "~> 2.0"
  s.add_development_dependency 'simplecov'
#   s.add_development_dependency "rspec-expectations", "~> 2.0" #
#   s.add_development_dependency "rr", "~> 1.0"                 #Если понадобятся добавим эти штуки
end
