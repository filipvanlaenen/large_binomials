# encoding: utf-8
#
# Ruby Library to Calculate Large Binomials
# Copyright (c) 2013 Filip van Laenen <f.a.vanlaenen@ieee.org>
#
# This file is part of the Ruby Library to Calculate Large Binomials.
#
# The Ruby Library to Calculate Large Binomials is free software: you can
# redistribute it and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# The Ruby Library to Calculate Large Binomials is distributed in the hope that
# it will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You can find a copy of the GNU General Public License in /LICENSE
#

module LargeBinomials
  # Class modeling floats larger than Ruby's regular float. They consist of a
  # regular float (the mantissa) plus an additional exponent of 10.
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
      unless @mantissa == 0
        normalization = Math.log10(@mantissa.abs).floor
        @mantissa /= 10**normalization
        @exponent += normalization
      end
    end

    def *(other)
      if other.instance_of? LargeFloat
        multiply_with_large_float(other)
      else
        multiply_with_numeric(other)
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
      product.normalize if new_mantissa == Float::INFINITY
      new_mantissa = product.mantissa * i
      if new_mantissa == Float::INFINITY
        product.exponent += 1
        i /= 10
      end
      product.mantissa *= i
      product
    end

    def /(other)
      if other.instance_of? LargeFloat
        divide_by_large_float(other)
      else
        divide_by_numeric(other)
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
      @mantissa + lf.mantissa * 10**(lf.exponent - @exponent)
    end

    def +(other)
      if self < other
        other + self
      else
        LargeFloat.new(new_mantissa_for_addition(other), @exponent)
      end
    end

    def superscript(i)
      s = i.to_s
      s = s.gsub(/1/, '¹').gsub(/2/, '²').gsub(/3/, '³').gsub(/4/, '⁴')
      s = s.gsub(/5/, '⁵').gsub(/6/, '⁶').gsub(/7/, '⁷').gsub(/8/, '⁸')
      s.gsub(/9/, '⁹').gsub(/0/, '⁰').gsub(/-/, '⁻')
    end

    def to_s
      normalize
      "#{@mantissa}×10#{superscript(@exponent)}"
    end

    def <=>(other)
      normalize
      other.normalize
      if @exponent == other.exponent
        @mantissa - other.mantissa
      else
        @exponent - other.exponent
      end
    end
  end
end
