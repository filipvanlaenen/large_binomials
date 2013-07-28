large_binomials
===============

This gem mixes in some general methods to calculate binomials to `Integer`. In
addition, it also mixes in some methods to calculate large binomials, with
“large” being defined as having a result greater than `Float.MAX`. The main
`Integer#binomial(k)` method is then adjusted such that when the result is less
than or equal to `Float.MAX`, an `Integer` is returned, and a
`LargeBinomials::LargeFloat` otherwise. Continuing to use `Integer` makes the
calculation of binomials more and more expensive as the result becomes larger
and larger.

Installation
------------

Do the following to install this gem:

1. Make a clone of the repository
2. Build the gem: `gem build large_binomials.gemspec`
3. Install the gem: `gem install ./large_binomials-0.9.gem`

Usage
-----

The following code (also included in the project as
`test_performance_binomial.rb`) shows how to use the library:

	# encoding: utf-8
	#
	# Test the performance of the calculation of a binomial
	#

	require 'benchmark'
	require 'large_binomials'

	puts "Going to test the performance of the calculation of a binomial."

	Samples = (1 .. 3).collect{ |i| 10 ** i}.collect{ |i| [1, 2, 3, 5].collect{ |j| j * i}}.flatten

	Samples.each{ |n|
		[1, n/100, n/10, n/2].each { |k|
			puts "#{n} C #{k}"
			c = 0
			time = Benchmark.realtime { c = n.binomial(k) }
			puts "  binomial: #{time}s (#{c})"
			time = Benchmark.realtime { c = n.float_binomial_by_product_of_divisions(k) }
			puts "  Π(/), float: #{time}s (#{c})"
			time = Benchmark.realtime { c = n.float_binomial_by_division_of_products(k) }
			puts "  Π/Π, float: #{time}s (#{c})"
			time = Benchmark.realtime { c = n.large_float_binomial_by_product_of_divisions(k) }
			puts "  Π(/), LargeFloat: #{time}s (#{c})"
			time = Benchmark.realtime { c = n.large_float_binomial_by_division_of_products(k) }
			puts "  Π/Π, LargeFloat: #{time}s (#{c})"
			time = Benchmark.realtime { c = n.binomial_by_division_of_parallel_products(k) }
			puts "  ∥Π/∥Π, integer: #{time}s (#{c})"
			time = Benchmark.realtime { c = n.binomial_by_division_of_products(k) }
			puts "  Π/Π, integer: #{time}s (#{c})"
			time = Benchmark.realtime { c = n.binomial_by_product_of_divisions(k) }
			puts "  Π(/), integer: #{time}s (#{c})"
			time = Benchmark.realtime { c = n.binomial_by_pascals_triangle(k) }
			puts "  ∑, integer: #{time}s (#{c})"
		}
	}

License
-------

Library to calculate large binomials  
Copyright (C) 2013  Filip van Laenen <f.a.vanlaenen@ieee.org>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.