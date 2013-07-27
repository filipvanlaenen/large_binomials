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

describe Integer, '#binomial' do
	it 'calculates the binomial C0,1 as 1' do
		1.binomial(0).should eq(1)
	end

	it 'calculates the binomial C1,2 as 2' do
		2.binomial(1).should eq(2)
	end

	it 'calculates the binomial C2,3 as 3' do
		3.binomial(2).should eq(3)
	end

	it 'calculates the binomial C2,4 as 6' do
		4.binomial(2).should eq(6)
	end
end