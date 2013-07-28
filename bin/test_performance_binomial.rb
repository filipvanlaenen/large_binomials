#!/usr/bin/ruby
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