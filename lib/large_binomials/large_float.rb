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

module LargeBinomials
	class LargeFloat
		include Comparable

		attr_accessor :exponent, :mantissa

		def initialize(m, e = 0)
			@mantissa = m.to_f
			@exponent = e
		end

		def clone
			LargeFloat.new(@mantissa, @exponent)
		end

		def normalize
			normalization = Math.log10(@mantissa).floor
			@mantissa /= 10 ** normalization
			@exponent += normalization
		end

		def *(x)
			if (x.instance_of? LargeFloat)
				multiply_with_large_float(x)
			else
				multiply_with_numeric(x)
			end
		end

		def multiply_with_large_float(lf)
			product = self * lf.mantissa
			product.exponent += lf.exponent
			product
		end

		def multiply_with_numeric(i)
			product = clone
			new_mantissa = product.mantissa * i
			if new_mantissa == Float::INFINITY
				product.normalize
			end
			product.mantissa *= i
			product
		end

		def /(x)
			if (x.instance_of? LargeFloat)
				divide_by_large_float(x)
			else
				divide_by_numeric(x)
			end
		end

		def divide_by_large_float(lf)
			quotient = self / lf.mantissa
			quotient.exponent -= lf.exponent
			quotient
		end

		def divide_by_numeric(n)
			quotient = clone
			quotient.mantissa /= n
			quotient
		end

		def new_mantissa_for_addition(lf)
			@mantissa + lf.mantissa * (10 ** (lf.exponent - @exponent))
		end

		def +(lf)
			if @exponent < lf.exponent
				lf + self
			else
				if new_mantissa_for_addition(lf) == Float::INFINITY
					normalize
					lf.normalize
				end
				LargeFloat.new(new_mantissa_for_addition(lf), @exponent)
			end
		end

		def superscript(i)
			s = i.to_s
			s = s.gsub(/1/, '¹')
			s = s.gsub(/2/, '²')
			s = s.gsub(/3/, '³')
			s = s.gsub(/4/, '⁴')
			s = s.gsub(/5/, '⁵')
			s = s.gsub(/6/, '⁶')
			s = s.gsub(/7/, '⁷')
			s = s.gsub(/8/, '⁸')
			s = s.gsub(/9/, '⁹')
			s.gsub(/0/, '⁰')
		end

		def to_s
			normalize
			"#{@mantissa}×10#{superscript(@exponent)}"
		end

		def <=>(lf)
			normalize
			lf.normalize
			if @exponent == lf.exponent
				@mantissa - lf.mantissa
			else
				@exponent - lf.exponent
			end
		end
	end
end