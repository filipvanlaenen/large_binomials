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

#	it 'calculates the binomial C1030,515 as 2.859641372997808×10³⁰⁸' do
#		1030.binomial(515).should eq(LargeBinomials::LargeFloat.new(2.859641372997808, 308))
#	end
end

describe Integer, '#binomial_by_product_of_divisions' do
	it 'calculates the binomial C0,1 as 1' do
		1.binomial_by_product_of_divisions(0).should eq(1)
	end

	it 'calculates the binomial C1,2 as 2' do
		2.binomial_by_product_of_divisions(1).should eq(2)
	end

	it 'calculates the binomial C2,3 as 3' do
		3.binomial_by_product_of_divisions(2).should eq(3)
	end

	it 'calculates the binomial C2,4 as 6' do
		4.binomial_by_product_of_divisions(2).should eq(6)
	end

	it 'calculates the binomial C1030,515 as 285964137299780816375713003417892828985047376491079895916065830932808184515508623336290716027603487838840658378528491902852969839049878057252288352997125670272624219209393564328660099438209732411401014699912025370547761703640450600215234966704145601511388368027664919136794617311260529388699426829733229057400' do
		1030.binomial_by_product_of_divisions(515).should eq(285964137299780816375713003417892828985047376491079895916065830932808184515508623336290716027603487838840658378528491902852969839049878057252288352997125670272624219209393564328660099438209732411401014699912025370547761703640450600215234966704145601511388368027664919136794617311260529388699426829733229057400)
	end
end

describe Integer, '#breaking_binomial_by_product_of_divisions' do
	it 'calculates the binomial C0,1 as 1' do
		1.breaking_binomial_by_product_of_divisions(0).should eq(1)
	end

	it 'calculates the binomial C1,2 as 2' do
		2.breaking_binomial_by_product_of_divisions(1).should eq(2)
	end

	it 'calculates the binomial C2,3 as 3' do
		3.breaking_binomial_by_product_of_divisions(2).should eq(3)
	end

	it 'calculates the binomial C2,4 as 6' do
		4.breaking_binomial_by_product_of_divisions(2).should eq(6)
	end

	it 'raises an error when calculating the binomial C1030,515' do
		 expect { 1030.breaking_binomial_by_product_of_divisions(515) }.to raise_error('Result larger than Float::MAX')
	end
end

describe Integer, '#large_float_binomial_by_product_of_divisions' do
#	it 'calculates the binomial C0,1 as 1×10⁰' do
#		1.large_float_binomial_by_product_of_divisions(0).should eq(LargeBinomials::LargeFloat.new(1))
#	end

#	it 'calculates the binomial C1,2 as 2×10⁰' do
#		2.large_float_binomial_by_product_of_divisions(1).should eq(LargeBinomials::LargeFloat.new(2))
#	end

#	it 'calculates the binomial C2,3 as 3×10⁰' do
#		3.large_float_binomial_by_product_of_divisions(2).should eq(LargeBinomials::LargeFloat.new(3))
#	end

#	it 'calculates the binomial C2,4 as 6×10⁰' do
#		4.large_float_binomial_by_product_of_divisions(2).should eq(LargeBinomials::LargeFloat.new(6))
#	end

#	it 'calculates the binomial C1030,515 as 2.859641372997808×10³⁰⁸' do
#		1030.large_float_binomial_by_product_of_divisions(515).should eq(LargeBinomials::LargeFloat.new(2.859641372997808, 308))
#	end
end
