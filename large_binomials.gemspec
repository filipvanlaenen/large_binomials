# -*- encoding: utf-8 -*-
#
# Ruby Library to Calculate Large Binomials
# Copyright © 2013 Filip van Laenen <f.a.vanlaenen@ieee.org>
#
# This file is part of the Ruby Library to Calculate Large Binomials.
#
# The Ruby Library to Calculate Large Binomials is free software: you can
# redistribute it and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
# 
# The Ruby Library to Calculate Large Binomials is distributed in the hope that
# it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
# 
# You can find a copy of the GNU General Public License in /LICENSE
#

Gem::Specification.new do |gem|
	gem.name = 'large_binomials'
	gem.version = '1.0beta1'
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