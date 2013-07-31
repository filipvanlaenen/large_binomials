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
	def create_one
		LargeBinomials::LargeFloat.new(1)
	end

	def multiply_by_two(lf)
		lf * 2
	end

	it 'creates a new LargeFloat with the mantissa multiplied with the argument' do
		one = create_one
		two = multiply_by_two(one)
		two.mantissa.should eq(2.to_f)
	end

	it "doesn't change the mantissa of the original LargeFloat" do
		one = create_one
		two = multiply_by_two(one)
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
	def create_one
		LargeBinomials::LargeFloat.new(1)
	end

	def divide_by_two(lf)
		lf / 2
	end

	it 'creates a new LargeFloat with the mantissa divided with the argument' do
		one = create_one
		two = divide_by_two(one)
		two.mantissa.should eq(0.5)
	end

	it "doesn't change the mantissa of the original LargeFloat" do
		one = create_one
		two = divide_by_two(one)
		one.mantissa.should eq(1.to_f)
	end
end

describe LargeBinomials::LargeFloat, '#divide_by_large_float' do
	def create_one
		LargeBinomials::LargeFloat.new(1)
	end

	def divide_by_large_float_two(lf)
		lf / LargeBinomials::LargeFloat.new(2, 2)
	end

	it "creates a new LargeFloat with the mantissa divided with the argument's mantissa" do
		one = create_one
		two = divide_by_large_float_two(one)
		two.mantissa.should eq(0.5)
	end

	it "creates a new LargeFloat with the exponent decremented with the argument's exponent" do
		one = create_one
		two = divide_by_large_float_two(one)
		two.exponent.should eq(-2)
	end

	it "doesn't change the mantissa of the original LargeFloat" do
		one = create_one
		two = divide_by_large_float_two(one)
		one.mantissa.should eq(1.to_f)
	end
end

describe LargeBinomials::LargeFloat, '#to_s' do
	it 'converts 1 to a string as 1.0×10⁰' do
		one = LargeBinomials::LargeFloat.new(1)
		one.to_s.should eq('1.0×10⁰')
	end

	it 'converts 10 to a string as 1.0×10¹' do
		one = LargeBinomials::LargeFloat.new(10)
		one.to_s.should eq('1.0×10¹')
	end

	it 'converts 1¹²³⁴⁵⁶⁷⁸⁹⁰ to a string as 1.0×10¹²³⁴⁵⁶⁷⁸⁹⁰' do
		one = LargeBinomials::LargeFloat.new(1, 1234567890)
		one.to_s.should eq('1.0×10¹²³⁴⁵⁶⁷⁸⁹⁰')
	end
end

describe LargeBinomials::LargeFloat, '#+' do
	it 'creates a new LargeFloat with the same value as the first one when 0 is added' do
		zero = LargeBinomials::LargeFloat.new(0)	
		one = LargeBinomials::LargeFloat.new(1)
		(one + zero).should eq(one)
	end

	it 'creates a new LargeFloat with the same value as the second one when added to 0' do
		zero = LargeBinomials::LargeFloat.new(0)	
		one = LargeBinomials::LargeFloat.new(1)
		(zero + one).should eq(one)
	end

	it 'creates a new LargeFloat with the exponent of the largest LargeFloat if the second exponent is greater' do
		one = LargeBinomials::LargeFloat.new(1)
		ten = LargeBinomials::LargeFloat.new(1, 1)
		eleven = one + ten
		eleven.exponent.should eq(1)
	end

	it 'creates a new LargeFloat with the exponent of the largest LargeFloat if the first exponent is greater' do
		one = LargeBinomials::LargeFloat.new(1)
		ten = LargeBinomials::LargeFloat.new(1, 1)
		eleven = ten + one
		eleven.exponent.should eq(1)
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
		one = LargeBinomials::LargeFloat.new(1)
		ten = LargeBinomials::LargeFloat.new(1, 1)
		eleven = one + ten
		eleven.mantissa.should eq(1.1)
	end

	it 'creates a new LargeFloat with the mantissa the sum of the mantissas relative to the exponents if the first exponent is greater' do
		one = LargeBinomials::LargeFloat.new(1)
		ten = LargeBinomials::LargeFloat.new(1, 1)
		eleven = ten + one
		eleven.mantissa.should eq(1.1)
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
		one = LargeBinomials::LargeFloat.new(1)
		below_accuracy = LargeBinomials::LargeFloat.new(1, -Math.log10(Float::MAX).floor - 1)
		(one + below_accuracy).should eq one
	end

	it 'creates a new LargeFloat equal to the first LargeFloat if the first is too small to be added' do
		one = LargeBinomials::LargeFloat.new(1)
		below_accuracy = LargeBinomials::LargeFloat.new(1, -Math.log10(Float::MAX).floor - 1)
		(below_accuracy + one).should eq one
	end
end

describe LargeBinomials::LargeFloat, '#<=>' do
	it 'returns 0 (equal) when mantissa and exponent are equal' do
		first_one = LargeBinomials::LargeFloat.new(1)
		second_one = LargeBinomials::LargeFloat.new(1)
		(first_one == second_one).should be_true
	end

	it 'returns 0 (equal) when mantissa and exponent are equal after normalization' do
		first_ten = LargeBinomials::LargeFloat.new(0.1, 2)
		second_ten = LargeBinomials::LargeFloat.new(10)
		(first_ten == second_ten).should be_true
	end

	it 'returns -1 (less than) when the first mantissa is smaller than the second, exponents being equal' do
		one = LargeBinomials::LargeFloat.new(1)
		two = LargeBinomials::LargeFloat.new(2)
		(one < two).should be_true
	end

	it 'returns -1 (less than) when the first exponent is smaller than the second' do
		one = LargeBinomials::LargeFloat.new(1)
		ten = LargeBinomials::LargeFloat.new(1, 1)
		(one < ten).should be_true
	end

	it 'returns -1 (less than) when the first exponent is smaller than the second after normalization' do
		one = LargeBinomials::LargeFloat.new(0.01, 2)
		ten = LargeBinomials::LargeFloat.new(1, 1)
		(one < ten).should be_true
	end
end
