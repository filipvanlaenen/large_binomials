# encoding: utf-8
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

class Integer

	def to_lf
		LargeBinomials::LargeFloat.new(self)
	end

	def binomial(k)
		binomial = breaking_binomial_by_product_of_divisions(k)
		if binomial == nil
			large_float_binomial_by_product_of_divisions(k)
		else
			binomial
		end
	end

	# Copied from http://rosettacode.org/wiki/Evaluate_binomial_coefficients#Ruby (on 7 June 2013)
	def binomial_by_product_of_divisions(k)
		(0...k).inject(1) do |m,i|
			(m * (self - i)) / (i + 1)
		end
	end

	# Breaking version of binomial_by_product_of_divisions
	def breaking_binomial_by_product_of_divisions(k)
		(0...k).inject(1) do |m,i|
			if m > Float::MAX
				return nil
			end
			(m * (self - i)) / (i + 1)
		end
	end

	# LargeFloat version of binomial_by_product_of_divisions
	def large_float_binomial_by_product_of_divisions(k)
		(0...k).inject(1.to_lf) do |m,i|
			(m * (self - i)) / (i + 1)
		end
	end

	# Float version of binomial_by_product_of_divisions
	def float_binomial_by_product_of_divisions(k)
		(0...k).inject(1.to_f) do |m,i|
			(m * (self - i)) / (i + 1)
		end
	end

	# From http://rosettacode.org/wiki/Evaluate_binomial_coefficients#Ruby (on 7 June 2013)
	def binomial_by_division_of_products(k)
		# n!/(n-k)!
		pTop = (self-k+1 .. self).inject(1, &:*) 
		# k!
		pBottom = (2 .. k).inject(1, &:*)
		pTop / pBottom
	end

	# Parallel version of binomial_by_division_of_products
	# Note that threads in Ruby 1.9 don't spread over multiple processors, so
	# due to context switching this parallel version will often be a bit slower
	# than the sequential one.
	def binomial_by_division_of_parallel_products(k)
		# n!/(n-k)!
		top_thread = Thread.new do
			Thread.current[:output] = (self-k+1 .. self).inject(1, &:*) 
		end
		# k!
		bottom_thread = Thread.new do
			Thread.current[:output] = (2 .. k).inject(1, &:*)
		end
		top_thread.join
		bottom_thread.join
		top_thread[:output] / bottom_thread[:output]
	end

	# LargeFloat version of binomial_by_division_of_products
	def large_float_binomial_by_division_of_products(k)
		# n!/(n-k)!
		pTop = (self-k+1 .. self).inject(1.to_lf, &:*) 
		# k!
		pBottom = (2 .. k).inject(1.to_lf, &:*)
		pTop / pBottom
	end

	# Float version of binomial_by_division_of_products
	def float_binomial_by_division_of_products(k)
		# n!/(n-k)!
		pTop = (self-k+1 .. self).inject(1.to_f, &:*) 
		# k!
		pBottom = (2 .. k).inject(1.to_f, &:*)
		pTop / pBottom
	end

	# Copied from http://www.brpreiss.com/books/opus8/html/page459.html (on 7 June 2013)
	def binomial_by_pascals_triangle(k)
		b = []
		b[0] = 1
		for i in 1 .. self
			b[i] = 1
			j = i - 1
			while j > 0
				b[j] += b[j - 1]
				j -= 1
			end
		end
		b[k]
	end

end