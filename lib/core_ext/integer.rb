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

	def binomial(k)
		begin
			breaking_binomial_by_product_of_divisions(k)
		rescue
			large_float_binomial_by_product_of_divisions(k)
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
			if (m > Float::MAX)
				raise 'Result larger than Float::MAX'
			end
			(m * (self - i)) / (i + 1)
		end
	end

	# LargeFloat version of binomial_by_product_of_divisions
	def large_float_binomial_by_product_of_divisions(k)
		(0...k).inject(LargeBinomials::LargeFloat.new(1)) do |m,i|
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

	# Float version of binomial_by_division_of_products
	def float_binomial_by_division_of_products(k)
		# n!/(n-k)!
		pTop = (self-k+1 .. self).inject(1.to_f, &:*) 
		# k!
		pBottom = (2 .. k).inject(1.to_f, &:*)
		pTop / pBottom
	end

end