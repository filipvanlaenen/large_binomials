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

class LargeFloat

	attr_reader :exponent
	attr_accessor :mantissa

	def initialize(m, e = 0)
		@mantissa = m.to_f
		@exponent = e
	end

	def clone
		LargeFloat.new(@mantissa, @exponent)
	end

	def normalize
		normalization = Math.log10(@mantissa)
		@mantissa /= 10 ** normalization
		@exponent += normalization
	end

	def *(i)
		product = clone
		new_mantissa = product.mantissa * i
		if (new_mantissa == Float::INFINITY)
			product.normalize
		end
		product.mantissa *= i
		product
	end

	def /(x)
		quotient = clone
		quotient.mantissa /= x
		quotient
	end

end