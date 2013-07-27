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

require 'spec_helper'

describe LargeFloat, '#initialize' do
	it "sets the mantissa correctly if there's only one argument" do
		lf = LargeFloat.new(1.to_f)
		lf.mantissa.should eq(1.to_f)
	end

	it "sets the exponent to zero if there's only one argument" do
		lf = LargeFloat.new(1.to_f)
		lf.exponent.should eq(0)
	end

	it 'sets the mantissa correctly if there are two arguments' do
		lf = LargeFloat.new(1.to_f, 0)
		lf.mantissa.should eq(1.to_f)
	end

	it 'converts the mantissa to a float' do
		lf = LargeFloat.new(1)
		lf.mantissa.should be_a_kind_of(Float)
	end
end