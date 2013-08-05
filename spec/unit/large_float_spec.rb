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

describe LargeBinomials::LargeFloat, '#initialize' do
	it "sets the mantissa correctly if there's only one argument" do
		lf = LargeBinomials::LargeFloat.new(1.to_f)
		lf.mantissa.should eq(1.to_f)
	end

	it "sets the exponent to zero if there's only one argument" do
		lf = LargeBinomials::LargeFloat.new(1.to_f)
		lf.exponent.should eq(0)
	end

	it 'sets the mantissa correctly if there are two arguments' do
		lf = LargeBinomials::LargeFloat.new(1.to_f, 0)
		lf.mantissa.should eq(1.to_f)
	end

	it 'converts the mantissa to a float' do
		lf = LargeBinomials::LargeFloat.new(1)
		lf.mantissa.should be_a_kind_of(Float)
	end
end

describe LargeBinomials::LargeFloat, '#multiply_by_numeric' do
	it 'creates a new LargeFloat with the mantissa multiplied with the argument' do
		(1.to_lf * 2).mantissa.should eq(2.to_f)
	end

	it "doesn't change the mantissa of the original LargeFloat" do
		one = 1.to_lf
		one * 2
		one.mantissa.should eq(1.to_f)
	end

	it "doesn't normalize without overflow (mantissa part)" do
		big_number = LargeBinomials::LargeFloat.new(1E+100)
		big_number_squared = big_number * 1E+100
		big_number_squared.mantissa.should eq(1E+200)
	end

	it "doesn't normalize without overflow (exponent part)" do
		big_number = LargeBinomials::LargeFloat.new(1E+100)
		big_number_squared = big_number * 1E+100
		big_number_squared.exponent.should eq(0)
	end

	it 'normalizes before overflow (mantissa part)' do
		big_number = LargeBinomials::LargeFloat.new(2E+300, 3)
		big_number_squared = big_number * 1E+300
		big_number_squared.mantissa.should eq(2E+300)
	end

	it 'normalizes before overflow (exponent part)' do
		big_number = LargeBinomials::LargeFloat.new(2E+300, 3)
		big_number_squared = big_number * 1E+300
		big_number_squared.exponent.should eq(303)
	end
	
	it "doesn't change the exponent of the original LargeFloat in case of overflow" do
		big_number = LargeBinomials::LargeFloat.new(1E+300, 3)
		big_number_squared = big_number * 1E+300
		big_number.exponent.should eq(3)
	end
end

describe LargeBinomials::LargeFloat, '#multiply_by_large_float' do
	def create_thirty
		LargeBinomials::LargeFloat.new(3, 1)
	end

	def multiply_by_two_hundred(lf)
		lf * LargeBinomials::LargeFloat.new(2, 2)
	end

	it 'creates a new LargeFloat with the mantissas multiplied together' do
		thirty = create_thirty
		six_thousand = multiply_by_two_hundred(thirty)
		six_thousand.mantissa.should eq(6.to_f)
	end

	it 'creates a new LargeFloat with the exponents added together' do
		thirty = create_thirty
		six_thousand = multiply_by_two_hundred(thirty)
		six_thousand.exponent.should eq(3)
	end

	it "doesn't change the mantissa of the original LargeFloat" do
		thirty = create_thirty
		six_thousand = multiply_by_two_hundred(thirty)
		thirty.mantissa.should eq(3.to_f)
	end

	it "doesn't normalize without overflow (mantissa part)" do
		big_number = LargeBinomials::LargeFloat.new(1E+100, 10)
		big_number_squared = big_number * big_number
		big_number_squared.mantissa.should eq(1E+200)
	end

	it "doesn't normalize without overflow (exponent part)" do
		big_number = LargeBinomials::LargeFloat.new(1E+100, 10)
		big_number_squared = big_number * big_number
		big_number_squared.exponent.should eq(20)
	end

	it 'normalizes before overflow (mantissa part)' do
		big_number = LargeBinomials::LargeFloat.new(2E+300, 3)
		big_number_squared = big_number * big_number
		big_number_squared.mantissa.should eq(4E+300)
	end

	it 'normalizes before overflow (exponent part)' do
		big_number = LargeBinomials::LargeFloat.new(2E+300, 3)
		big_number_squared = big_number * big_number
		big_number_squared.exponent.should eq(306)
	end
	
	it "doesn't change the exponent of the original LargeFloat in case of overflow" do
		big_number = LargeBinomials::LargeFloat.new(1E+300, 3)
		big_number_squared = big_number * big_number
		big_number.exponent.should eq(3)
	end
end

describe LargeBinomials::LargeFloat, '#divide_by_numeric' do
	it 'creates a new LargeFloat with the mantissa divided with the argument' do
		(1.to_lf / 2).mantissa.should eq(0.5)
	end

	it "doesn't change the mantissa of the original LargeFloat" do
		one = 1.to_lf
		one / 2
		one.mantissa.should eq(1.to_f)
	end
end

describe LargeBinomials::LargeFloat, '#divide_by_large_float' do
	def divide_by_large_float_two_hundred(lf)
		lf / LargeBinomials::LargeFloat.new(2, 2)
	end

	it "creates a new LargeFloat with the mantissa divided with the argument's mantissa" do
		quotient = divide_by_large_float_two_hundred(1.to_lf)
		quotient.mantissa.should eq(0.5)
	end

	it "creates a new LargeFloat with the exponent decremented with the argument's exponent" do
		quotient = divide_by_large_float_two_hundred(1.to_lf)
		quotient.exponent.should eq(-2)
	end

	it "doesn't change the mantissa of the original LargeFloat" do
		one = 1.to_lf
		divide_by_large_float_two_hundred(one)
		one.mantissa.should eq(1.to_f)
	end
end

describe LargeBinomials::LargeFloat, '#to_s' do
	it 'converts 1 to a string as 1.0×10⁰' do
		1.to_lf.to_s.should eq('1.0×10⁰')
	end

	it 'converts 10 to a string as 1.0×10¹' do
		10.to_lf.to_s.should eq('1.0×10¹')
	end

	it 'converts 1¹²³⁴⁵⁶⁷⁸⁹⁰ to a string as 1.0×10¹²³⁴⁵⁶⁷⁸⁹⁰' do
		LargeBinomials::LargeFloat.new(1, 1234567890).to_s.should eq('1.0×10¹²³⁴⁵⁶⁷⁸⁹⁰')
	end

	it 'converts 1¹²³⁴⁵⁶⁷⁸⁹⁰¹²³⁴⁵⁶⁷⁸⁹⁰ to a string as 1.0×10¹²³⁴⁵⁶⁷⁸⁹⁰¹²³⁴⁵⁶⁷⁸⁹⁰' do
		LargeBinomials::LargeFloat.new(1, 12345678901234567890).to_s.should eq('1.0×10¹²³⁴⁵⁶⁷⁸⁹⁰¹²³⁴⁵⁶⁷⁸⁹⁰')
	end
end

describe LargeBinomials::LargeFloat, '#+' do
	it 'creates a new LargeFloat with the same value as the first one when 0 is added' do
		(1.to_lf + 0.to_lf).should eq(1.to_lf)
	end

	it 'creates a new LargeFloat with the same value as the second one when added to 0' do
		(0.to_lf + 1.to_lf).should eq(1.to_lf)
	end

	it 'creates a new LargeFloat with the exponent of the largest LargeFloat if the second exponent is greater' do
		(1.to_lf + LargeBinomials::LargeFloat.new(1, 1)).exponent.should eq(1)
	end

	it 'creates a new LargeFloat with the exponent of the largest LargeFloat if the first exponent is greater' do
		(LargeBinomials::LargeFloat.new(1, 1) + 1.to_lf).exponent.should eq(1)
	end

	it 'creates a new LargeFloat with the exponent of the largest LargeFloat normalized if the second exponent is greater and in case of overflow' do
		max_float = LargeBinomials::LargeFloat.new(Float::MAX)
		max_float_times_ten = LargeBinomials::LargeFloat.new(Float::MAX, 1)
		max_float_times_eleven = max_float + max_float_times_ten
		max_float_times_eleven.exponent.should eq(Math.log10(Float::MAX).floor + 1)
	end

	it 'creates a new LargeFloat with the exponent of the largest LargeFloat normalized if the first exponent is greater and in case of overflow' do
		max_float = LargeBinomials::LargeFloat.new(Float::MAX)
		max_float_times_ten = LargeBinomials::LargeFloat.new(Float::MAX, 1)
		max_float_times_eleven = max_float_times_ten + max_float
		max_float_times_eleven.exponent.should eq(Math.log10(Float::MAX).floor + 1)
	end

	it 'creates a new LargeFloat with the mantissa the sum of the mantissas relative to the exponents if the second exponent is greater' do
		(1.to_lf + LargeBinomials::LargeFloat.new(1, 1)).mantissa.should eq(1.1)
	end

	it 'creates a new LargeFloat with the mantissa the sum of the mantissas relative to the exponents if the first exponent is greater' do
		(LargeBinomials::LargeFloat.new(1, 1) + 1.to_lf).mantissa.should eq(1.1)
	end

	it 'creates a new LargeFloat with the mantissa the sum of the mantissas relative to the exponents normalized if the second exponent is greater and in case of overflow' do
		max_float = LargeBinomials::LargeFloat.new(Float::MAX)
		max_float_times_ten = LargeBinomials::LargeFloat.new(Float::MAX, 1)
		max_float_times_eleven = max_float + max_float_times_ten
		max_mantissa = Float::MAX / (10 ** Math.log10(Float::MAX).floor)
		max_float_times_eleven.mantissa.should eq(max_mantissa + max_mantissa / 10)
	end

	it 'creates a new LargeFloat with the mantissa the sum of the mantissas relative to the exponents normalized if the first exponent is greater and in case of overflow' do
		max_float = LargeBinomials::LargeFloat.new(Float::MAX)
		max_float_times_ten = LargeBinomials::LargeFloat.new(Float::MAX, 1)
		max_float_times_eleven = max_float_times_ten + max_float
		max_mantissa = Float::MAX / (10 ** Math.log10(Float::MAX).floor)
		max_float_times_eleven.mantissa.should eq(max_mantissa + max_mantissa / 10)
	end

	it 'creates a new LargeFloat equal to the first LargeFloat if the second is too small to be added' do
		below_accuracy = LargeBinomials::LargeFloat.new(1, -Math.log10(Float::MAX).floor - 1)
		(1.to_lf + below_accuracy).should eq 1.to_lf
	end

	it 'creates a new LargeFloat equal to the first LargeFloat if the first is too small to be added' do
		below_accuracy = LargeBinomials::LargeFloat.new(1, -Math.log10(Float::MAX).floor - 1)
		(below_accuracy + 1.to_lf).should eq 1.to_lf
	end
end

describe LargeBinomials::LargeFloat, '#<=>' do
	it 'returns 0 (equal) when mantissa and exponent are equal' do
		(1.to_lf == 1.to_lf).should be_true
	end

	it 'returns 0 (equal) when mantissa and exponent are equal after normalization' do
		(LargeBinomials::LargeFloat.new(0.1, 2) == 10.to_lf).should be_true
	end

	it 'returns -1 (less than) when the first mantissa is smaller than the second, exponents being equal' do
		(1.to_lf < 2.to_lf).should be_true
	end

	it 'returns -1 (less than) when the first exponent is smaller than the second' do
		(1.to_lf < LargeBinomials::LargeFloat.new(1, 1)).should be_true
	end

	it 'returns -1 (less than) when the first exponent is smaller than the second after normalization' do
		one = LargeBinomials::LargeFloat.new(0.01, 2)
		ten = LargeBinomials::LargeFloat.new(1, 1)
		(one < ten).should be_true
	end
end
