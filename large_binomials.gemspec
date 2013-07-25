# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name = 'large_binomials'
  gem.version = '0.1alpha1'
  gem.authors = [ 'Filip van Laenen' ]
  gem.email = [ 'f.a.vanlaenen@ieee.org' ]

  gem.description = 'Large binomials'
  gem.summary = 'Library to calculate large binomials'
  gem.homepage = 'https://github.com/filipvanlaenen/large_binomials'
  gem.license = 'GPL'

  gem.require_paths = [ 'lib' ]
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- spec`.split("\n")
  gem.extra_rdoc_files = %w[LICENSE README.md]

end